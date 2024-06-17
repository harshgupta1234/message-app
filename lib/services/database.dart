import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message/models/models.dart';

class DatabaseBackend {
  final String? uid;
  final String? friuid;
  DatabaseBackend({this.uid , this.friuid});

  final CollectionReference allUser = FirebaseFirestore.instance.collection('users');
  final CollectionReference Userdata = FirebaseFirestore.instance.collection('data');

  Future<String> _currentusername() async{
    return await allUser.doc(uid).get().then((value) => value.get('username'));
  }



  Future updateUserData({String? name, String? email}) async {
    return await allUser.doc(uid).set({
      'username': name,
      'email': email,
    });
  }



  Future adduserdatawithemail({String? email}) async{
     await Userdata.doc(email).set({
      'uid' : uid,
    });
  }



  Future _getuidfromemail({String? email}) async{
    return await Userdata.doc(email).get().then((value) => value.get('uid'));
  }



  UserName _getnameofuser(DocumentSnapshot snapshot){
    return UserName(
      name: snapshot.get('username'),
    );
  }
  Stream<UserName> get usernameInStream{
    return allUser.doc(uid).snapshots().map(_getnameofuser);
  }



  Future addfriendinyours({required String friendsemail, String? friendsname}) async {
    String friendsuid =await _getuidfromemail(email: friendsemail);
    int? numberofchats =10000000000;
    try {
      numberofchats = await allUser
          .doc(uid)
          .collection('friends')
          .doc(friendsuid)
          .get()
          .then((value) => value.get('numberofchats'));
    }catch(e){};

    return await allUser.doc(uid).collection('friends').doc(friendsuid).set({
      'friendemail' : friendsemail,
      'userfriend': friendsname,
      'numberofchats' : numberofchats,
    });
  }
  Future addyouinfriends({required String friendsemail,String? email}) async {
    String currentuser =await _currentusername();
    String friendsuid =await _getuidfromemail(email: friendsemail);
    int? numberofchats =10000000000;
    try {
      numberofchats = await allUser
          .doc(friendsuid)
          .collection('friends')
          .doc(uid)
          .get()
          .then((value) => value.get('numberofchats'));
    }catch(e){};
    return await allUser.doc(friendsuid).collection('friends').doc(uid).set({
      'friendemail' : email,
      'userfriend': currentuser,
      'numberofchats' : numberofchats,
    });
  }



  List<FriendDetail> _friendlistfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      // print(doc.id);
      return FriendDetail(
        frienduid: doc.id,
        friendemail: doc.get('friendemail'),
        friendname : doc.get('userfriend'),
        numberofchats: doc.get('numberofchats')
      );
    }).toList();
  }
  Stream<List<FriendDetail>> get friendlist{
    {
      return allUser
          .doc(uid)
          .collection('friends')
          .snapshots()
          .map(_friendlistfromsnapshot);
    }
  }




  Future updatefrienddetail(
      {String? friendemail, String? friendname, int? numberofchats}) async {
    await allUser.doc(uid).collection('friends').doc(friuid).set({
      'friendemail': friendemail,
      'userfriend' : friendname,
      'numberofchats' : numberofchats,
    });
  }





  Future<void> _increasenumberofchatsdata({ String? frienduid ,String? uid,int? numberofchats}) async{
    String friendname=await allUser.doc(uid).collection('friends').doc(frienduid).get().then((value) => value.get('userfriend'));
    String friendemail=await allUser.doc(uid).collection('friends').doc(frienduid).get().then((value) => value.get('friendemail'));
    await allUser.doc(uid).collection('friends').doc(frienduid).set({
      'friendemail': friendemail,
      'userfriend' : friendname,
      'numberofchats' : numberofchats,
    });
  }

  Future sendmessage({String? message,String? frienduid,String? uid,int? numberofchats})async {
    numberofchats=(numberofchats!+1);
    await _increasenumberofchatsdata(frienduid: frienduid, uid: uid, numberofchats: numberofchats);
    return await allUser.doc(uid).collection('friends').doc(frienduid).collection('chats').doc(numberofchats.toString()).set({
      'send' : message,
      'receive' : null,
    });
  }

  Future receivemessage({String? message,String? frienduid,String? uid,int? numberofchats,})async {
    await _increasenumberofchatsdata(frienduid: uid, uid: frienduid, numberofchats: numberofchats);
    return await allUser.doc(frienduid).collection('friends').doc(uid).collection('chats').doc(numberofchats.toString()).set({
      'send' : null,
      'receive' : message,
    });
  }



  List<ChatList> _chatlistfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return ChatList(
          send : doc.get('send'),
          receive: doc.get('receive'),
      );
    }).toList();
  }
  Stream<List<ChatList>> get chats{
    return allUser.doc(uid).collection('friends').doc(friuid).collection('chats').snapshots().map(_chatlistfromsnapshot);
  }


}

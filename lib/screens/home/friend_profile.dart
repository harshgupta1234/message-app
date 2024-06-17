import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/models/models.dart';
import 'package:message/services/database.dart';
import 'package:provider/provider.dart';

class FriendProfile extends StatefulWidget {
  static const String route = '/friendprofile';
  const FriendProfile({Key? key}) : super(key: key);

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  String? newfriendname ;
  @override
  Widget build(BuildContext context) {
    FriendDetail? friend =
        ModalRoute.of(context)!.settings.arguments as FriendDetail?;
    final _user = Provider.of<User?>(context);


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.blue,
            ),
          ),
        ),
        title: Text(
          newfriendname ?? friend?.friendname ?? '',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo5jtwYwUeucAkm_jkZ1u9y3JBrC3wyMmTEA&usqp=CAU'),
                        radius: 50,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        initialValue: friend?.friendname,
                        onChanged: (val) {
                          setState(() {
                            newfriendname = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20)
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text('Email :',
                        style: TextStyle(color: Colors.black54, fontSize: 16)),
                    SizedBox(width: 10),
                    Text(friend?.friendemail ?? '',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 50),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text('Number of Conversations :',
                        style: TextStyle(color: Colors.black54, fontSize: 16)),
                    SizedBox(width: 10),
                    Text(((friend?.numberofchats ?? 10000000000) - 10000000000).toString(),
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 60),
                Center(
                    child: ElevatedButton(
                        onPressed: () async{
                          await DatabaseBackend(uid: _user?.uid, friuid: friend?.frienduid).updatefrienddetail(
                                  friendemail: friend?.friendemail,
                                  friendname: newfriendname ?? friend?.friendname,
                                  numberofchats: friend?.numberofchats);
                        },
                        child: Text('Update')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

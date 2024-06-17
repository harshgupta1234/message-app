import 'package:firebase_auth/firebase_auth.dart';
import 'package:message/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user{
    return _auth.authStateChanges();
  }



  Future signup(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user =result.user;
      await DatabaseBackend(uid: user?.uid).updateUserData(name: 'New User' ,email: user?.email);
      await DatabaseBackend(uid: user?.uid).adduserdatawithemail(email: user?.email);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future login(String email , String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      User? user =result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  Future logout() async{
    try{
      await _auth.signOut();

    }catch(e){
      print(e.toString());
      return  null;
    }
  }


}
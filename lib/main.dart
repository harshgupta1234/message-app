import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message/screens/home/chatbox.dart';
import 'package:message/screens/home/friend_profile.dart';
import 'package:message/screens/home/userprofile.dart';
import 'package:message/screens/wrapper.dart';
import 'package:message/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthService _auth = AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: _auth.user,
        child: MaterialApp(
            home: Wrapper(),
          routes: {
            '/chatbox': (context) => ChatBox(),
            '/userprofile':(context) => UserProfile(),
            '/friendprofile':(context) => FriendProfile(),
          },
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:message/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    // print(user?.email);
    // print(user?.uid);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

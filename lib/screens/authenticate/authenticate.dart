import 'package:flutter/material.dart';
import 'package:message/screens/authenticate/sign_in.dart';
import 'package:message/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signinpage = true;

  void toggleview() {
    setState(() {
      signinpage = !signinpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signinpage) {
      return SignIn(Toggleview: toggleview);
    } else {
      return SignUp(Toggleview: toggleview);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:message/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function Toggleview;

  const SignUp({required this.Toggleview});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async {
                    dynamic result = await _auth.signup(email, password);
                    // print(result.get('uid'));
                  },
                  child: Text('Sign Up')),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a user ?'),
                  TextButton(
                      onPressed: () {
                        widget.Toggleview();
                      },
                      child: Text('Sign In'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

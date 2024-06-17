import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/services/database.dart';
import 'package:provider/provider.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  String friendsemail='';
  String friendsname='';


  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (val) {
              setState(() {
                friendsemail=val;
              });
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            onChanged: (val) {
              setState(() {
                friendsname=val;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {
            // print(friendsuid);
            // print(friendsname);
            DatabaseBackend(uid: _user?.uid).addfriendinyours(friendsemail: friendsemail, friendsname: friendsname);
            DatabaseBackend(uid: _user?.uid).addyouinfriends(friendsemail: friendsemail,email:_user?.email);
            Navigator.pop(context);
          }, child: Text('Add Friend')),
        ],
      ),
    );
  }
}

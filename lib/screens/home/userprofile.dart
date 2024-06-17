import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/models/models.dart';
import 'package:message/services/database.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static const String route = '/userprofile';
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? newusername;
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return StreamBuilder<UserName>(
        stream: DatabaseBackend(uid: _user?.uid).usernameInStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserName? username = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.blue),
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.blue),
                ),
                backgroundColor: Colors.white,
              ),
              body: Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo5jtwYwUeucAkm_jkZ1u9y3JBrC3wyMmTEA&usqp=CAU'),
                            radius: 70,
                          ),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name',labelStyle: TextStyle(fontSize: 19)),
                          initialValue: username?.name,
                          onChanged: (val) {
                            setState(() {
                              newusername = val;
                            });
                          },
                        ),
                        SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email :',
                                style:
                                    TextStyle(color: Colors.black54, fontSize: 16)),
                            SizedBox(width: 10),
                            Text(_user?.email ?? '',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 40),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  DatabaseBackend(uid: _user?.uid).updateUserData(name: newusername ?? username?.name,email: _user?.email);
                                }, child: Text('Update')))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          ;
          return Scaffold();
        });
  }
}

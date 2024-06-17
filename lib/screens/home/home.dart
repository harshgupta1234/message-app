import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/screens/home/adduserform.dart';
import 'package:message/screens/home/drawer.dart';
import 'package:message/screens/home/friends_list.dart';
import 'package:message/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:message/services/database.dart';
import 'package:message/models/models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    void _adduserpanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: AddUserForm(),
            );
          });
    }

    return StreamProvider<List<FriendDetail>>.value(
      initialData: [],
      value: DatabaseBackend(uid: _user?.uid).friendlist,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'All Chats',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          actions: [
            TextButton.icon(
                onPressed: () {
                  _auth.logout();
                },
                label: Text('Log Out'),
                icon: Icon(Icons.logout))
          ],
        ),
        drawer: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.6,
            color: Colors.blue[100],
            child: DrawerArea(),
          ),
        ),
        body: Container(
          child: FriendsChats(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _adduserpanel();
          },
          child: Icon(Icons.person_add),
        ),
      ),
    );
  }
}

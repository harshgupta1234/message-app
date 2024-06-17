import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerArea extends StatelessWidget {
  const  DrawerArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            color: Colors.white,
            child: ListTile(
              onTap:()  async{
                Navigator.pop(context);
                await Navigator.pushNamed(context, '/userprofile');
              },
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo5jtwYwUeucAkm_jkZ1u9y3JBrC3wyMmTEA&usqp=CAU'),
              ),
              title: Text(_user!.email ?? ''),
              subtitle: Text(
                'View Profile',
                style: TextStyle(color: Colors.black38),
              ),
            ),
          )
        ],
      ),
    );
  }
}

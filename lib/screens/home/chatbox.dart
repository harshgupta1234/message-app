import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/models/models.dart';
import 'package:message/screens/home/chats.dart';
import 'package:message/screens/home/send_button.dart';
import 'package:message/services/database.dart';
import 'package:provider/provider.dart';

class ChatBox extends StatefulWidget {
  static const String route = '/chatbox';
  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final controller = ScrollController();
  String? message;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    int index =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());

    return StreamBuilder<List<FriendDetail>>(
        stream: DatabaseBackend(uid: _user?.uid).friendlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            FriendDetail? friend = snapshot.data![index];
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
                      child: Icon(Icons.arrow_back_rounded,
                      color: Colors.blue,),
                    ),
                  ),
                  title: RawMaterialButton(
                    onPressed: () async{
                        await Navigator.pushNamed(context, '/friendprofile',arguments: snapshot.data![index]);

                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo5jtwYwUeucAkm_jkZ1u9y3JBrC3wyMmTEA&usqp=CAU'),
                        ),
                        SizedBox(width: 12),
                        Text(
                          friend.friendname ?? '',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,60),
                  child: ChatTree(friuid: friend.frienduid),
                ),
              bottomSheet: SendButton(friuid: friend.frienduid , numberofchats: friend.numberofchats,controller: controller),
            );
          } else {};
          return Container();
        });
  }
}

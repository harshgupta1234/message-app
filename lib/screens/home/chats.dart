import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/models/models.dart';
import 'package:message/screens/home/chat.dart';
import 'package:message/services/database.dart';
import 'package:provider/provider.dart';

class ChatTree extends StatefulWidget {
  final String? friuid;
  ChatTree({this.friuid});

  @override
  State<ChatTree> createState() => _ChatTreeState();
}

class _ChatTreeState extends State<ChatTree> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    // print(_user?.uid);
    // print(widget.friuid);
    return StreamBuilder<List<ChatList>>(
        stream: DatabaseBackend(uid: _user?.uid, friuid: widget.friuid).chats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChatList>? chats = snapshot.data;
            return ListView.builder(
              reverse: true,
              itemCount: chats!.length,
              itemBuilder: (context, index) {
                return ChatTile(chat: chats[chats.length-index-1]);
              },
            );
          };
          return Container();
        });
  }
}

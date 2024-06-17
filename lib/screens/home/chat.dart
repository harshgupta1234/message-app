import 'package:flutter/material.dart';
import 'package:message/models/models.dart';

class ChatTile extends StatelessWidget {
  final ChatList chat;

  const ChatTile({required this.chat});



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            chat.receive != null
                ? Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo5jtwYwUeucAkm_jkZ1u9y3JBrC3wyMmTEA&usqp=CAU'),),
                    SizedBox(width: 7),
                    Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 1.6,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue[chat.receive == null ? 0 : 50],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(15))),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Text(chat.receive ?? '',
                            style: TextStyle(
                                fontSize: 17, letterSpacing: 0.35, wordSpacing: 1)),
                      ),
                  ],
                )
                : Container(),
            chat.send != null
                ? Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.6,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue[chat.send == null ? 0 : 200],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(15))),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(chat.send ?? '',
                        style: TextStyle(
                            fontSize: 17, letterSpacing: 0.35, wordSpacing: 1)),
                  )
                : Container(),
          ],
        ));
  }
}

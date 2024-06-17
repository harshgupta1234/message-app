import 'package:flutter/material.dart';
import 'package:message/models/models.dart';
import 'package:provider/provider.dart';

class FriendsChats extends StatefulWidget {
  const FriendsChats({Key? key}) : super(key: key);

  @override
  State<FriendsChats> createState() => _FriendsChatsState();
}

class _FriendsChatsState extends State<FriendsChats> {
  @override
  Widget build(BuildContext context) {

    final friends = Provider.of<List<FriendDetail>>(context);

    return ListView.builder(
      itemCount: friends.length,
        itemBuilder: (context,index){
        return Card(
          elevation: 0,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            onTap: () {
              Navigator.pushNamed(context, '/chatbox',arguments: index);
            },
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo5jtwYwUeucAkm_jkZ1u9y3JBrC3wyMmTEA&usqp=CAU'),
            ),
            title: Text(friends[index].friendname ?? ''),
          ),
        );
        }
    );
  }
}

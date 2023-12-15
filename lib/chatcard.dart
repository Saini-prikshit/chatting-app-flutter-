import 'package:flutter/material.dart';
import 'package:myapp/chat_screen.dart';
import 'package:myapp/chat_user.dart';


class ChatCard extends StatefulWidget {
  final ChatUser user;
  const ChatCard({super.key, required this.user});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
       elevation: 3,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(user: widget.user),));
      },
      child:  ListTile(
         leading: CircleAvatar(backgroundColor: Colors.white,backgroundImage: NetworkImage(widget.user.image.toString()),radius: 25),
        title: Text(widget.user.name),
        subtitle: Text(widget.user.about),
      ),
      )
      );
  }
}

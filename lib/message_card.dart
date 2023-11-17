import 'package:flutter/material.dart';
import 'package:myapp/API.dart';
import 'package:myapp/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message,});
  final Message message;
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Apis.auth.currentUser!.uid == widget.message.Fromid
        ? bluemsg()
        : greymsg();
  }


  Widget bluemsg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 5),
            if(widget.message.read.isNotEmpty)
            const Icon(Icons.done_all_rounded,color: Colors.blue,size: 20),
            const SizedBox(width: 2),
            Text( Mydate.getTime(context: context, time: widget.message.sent)
              ,style: const TextStyle(fontSize: 16,color: Colors.black54),),
          ],
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(right: 10,top: 10),
            decoration: BoxDecoration(color: Colors.blue.shade100,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),
                    topRight:  Radius.circular(30),
                    bottomLeft: Radius.circular(30)) ),
            child: Text(widget.message.msg ,style: const TextStyle(fontSize: 20),),
          ),
        ),
      ],
    );
  }

  Widget greymsg() {
    if(widget.message.read.isEmpty){
      Apis.messageStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 10,top: 10),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.30),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),
                    topRight:  Radius.circular(30),
                    bottomRight: Radius.circular(30)) ),
            child: Text( widget.message.msg
              ,style: const TextStyle(fontSize: 20),),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(Mydate.getTime(context: context, time: widget.message.sent)
            ,style: const TextStyle(fontSize: 16,color: Colors.black54),),
        )
      ],
    );
  }
}

class Mydate{
  static String getTime({required BuildContext context,required String time}){
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}

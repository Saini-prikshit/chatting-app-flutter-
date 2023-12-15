import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myapp/API.dart';
import 'package:myapp/chat_user.dart';
import 'package:myapp/message_card.dart';
import 'message.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> list = [];
  final _textControl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool showEmoji = false;

  @override
  void initState() {
    _scrollController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (showEmoji) {
          setState(() {
            showEmoji = !showEmoji;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade500,
            title: Title(
                color: Colors.white,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(widget.user.image.toString()),
                      radius: 24,
                    ),
                    SizedBox(width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.015),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.user.name),
                        SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),
                      ],
                    ),
                  ],
                )),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: Apis.getMessage(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                            child: (CircularProgressIndicator()));
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        list = data
                            ?.map((e) => Message.fromJson(e.data()))
                            .toList() ??
                            [];
                    }

                    if (list.isNotEmpty) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return ListView.builder(
                        itemCount: list.length,
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          //if(index == list.length){return Container(height: 20,);}
                          return MessageCard(
                            message: list[index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Say Hii ',
                          style: TextStyle(fontSize: 26),
                        ),
                      );
                    }
                  },
                ),
              ),
              chatInput(),
              if (showEmoji)
                SizedBox(
                  height: 270,
                  child: EmojiPicker(
                    textEditingController: _textControl,
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget chatInput() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        showEmoji = !showEmoji;
                      });
                    },
                    icon: Icon(Icons.emoji_emotions,
                        size: 28, color: Colors.black.withOpacity(0.75)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _textControl,
                      onTap: () {
                        setState(() {
                          if (showEmoji) {
                            showEmoji = !showEmoji;
                          }
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(fontSize: 17),
                      decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_textControl.text.isNotEmpty) {
                Apis.sendMessage(widget.user, _textControl.text);
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn);
                _textControl.text = '';
              }
            },
            minWidth: 70,
            padding:
            const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
            color: Colors.black.withOpacity(0.70),
            shape: const CircleBorder(),
            child: const Icon(Icons.send, color: Colors.white, size: 30),
          )
        ],
      ),
    );
  }
}

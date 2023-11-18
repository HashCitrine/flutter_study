import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_study/chat_papa/Chat.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _chats = [];
  final GlobalKey<AnimatedListState> _aniListKey = GlobalKey();

  Chat buildChat(context, index, animation) {
    return Chat(message: _chats[index], id: "teamok.kim", animation: animation);
  }

  void handleSubmitted(String message) {
    Logger().d("Send Message : $message");
    _chats.insert(0, message);
    _aniListKey.currentState!.insertItem(0);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Platform.isIOS
          ? const CupertinoNavigationBar(
              middle: Text("Chat App"),
            )
          : AppBar(
              title: const Text("Chat App"),
            )) as PreferredSizeWidget,
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _aniListKey,
              reverse: true,
              itemBuilder: buildChat,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(hintText: "메시지 입력"),
                    onSubmitted: handleSubmitted,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Platform.isIOS
                    ? ElevatedButton(
                        child: const Text("send"),
                        onPressed: () {
                          handleSubmitted(_textEditingController.text);
                        },
                      )
                    : ElevatedButton(
                        onPressed: () {
                          handleSubmitted(_textEditingController.text);
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amberAccent),
                        ),
                        child: const Text("Send"),
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

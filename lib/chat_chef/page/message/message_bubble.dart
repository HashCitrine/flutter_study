import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String uid;
  final String name;
  final String image;

  const MessageBubble(this.message, this.uid, this.name, this.image,
      {super.key});

  bool isMe() {
    return FirebaseAuth.instance.currentUser!.uid == uid;
  }

  Container oldBubble() {
    return Container(
      decoration: BoxDecoration(
        color: isMe() ? Colors.blue : Colors.grey[400],
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
            bottomRight: isMe() ? Radius.circular(0) : Radius.circular(12),
            bottomLeft: isMe() ? Radius.circular(12) : Radius.circular(0)),
      ),
      width: 145,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Padding newBubble(context) {
    if (isMe())
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 40,0),
        child: ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 20),
          backGroundColor: Colors.blue,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 15, 0, 0),
        child: ChatBubble(
          clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
          backGroundColor: Color(0xffE7E7ED),
          margin: EdgeInsets.only(top: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe() ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            // oldBubble(),
            newBubble(context),
          ],
        ),
        Positioned(
          top: 0,
          right: isMe() ? 10 : null,
          left: isMe() ? null : 10,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
      ],
    );
  }
}

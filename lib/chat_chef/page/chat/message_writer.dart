import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWriter extends StatefulWidget {
  @override
  State<MessageWriter> createState() => _MessageWriterState();
}

class _MessageWriterState extends State<MessageWriter> {
  String _enterMessage = '';
  final controller = TextEditingController();

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userInfo = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'message': _enterMessage,
        'time': Timestamp.now(),
        'uid': user.uid,
        'name': userInfo.data()!['userName'],
        'image':userInfo.data()!['image'],
      },
    );
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Write message...',
              ),
              onChanged: (value) {
                setState(() {
                  _enterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enterMessage.trim().isEmpty ? null : sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/chat_chef/page/chat/message_log.dart';
import 'package:flutter_study/chat_chef/page/chat/message_writer.dart';
import 'package:logger/logger.dart';

class ChatRoom extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  User? loggedUser;

  void get currentUser {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedUser = user;
        Logger().d(loggedUser!.email);
      }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
    }
  }

  ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _auth.signOut();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          actions: [
            IconButton(
              onPressed: () {
                _auth.signOut();
                /** remove popup */
                // Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        /** Temp Message */
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('chats/OQdGOLY7zkhZZ8hfzae8/message/')
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //
        //     final docs = snapshot.data!.docs;
        //     return ListView.builder(
        //       itemCount: docs.length,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           child: Text(docs[index]['message']),
        //         );
        //       },
        //     );
        //   },
        // ),
        body: Container(
          child: Column(
            children: [
              Expanded(child: MessageLog()),
              MessageWriter(),
            ],
          ),
        ),
      ),
    );
  }
}

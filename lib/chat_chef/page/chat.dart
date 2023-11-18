import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/chat_chef/app.dart';
import 'package:logger/logger.dart';

class Chat extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  User? loggedUser;

  void get currentUser {
    try {
      final user = _auth.currentUser;

      if(user != null) {
        loggedUser = user;
        Logger().d(loggedUser!.email);
      }
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
    }

  }

  Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Chat'),
      ),
    );
  }
}

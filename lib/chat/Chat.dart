import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final String id;
  final String message;
  final Animation<double> animation;

  const Chat(
      {super.key,
      required this.message,
      required this.id,
      required this.animation});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1.0,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  child: Text(id.substring(0, 1).toUpperCase()),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      id,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(message),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

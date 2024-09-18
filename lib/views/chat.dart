import 'package:chat_app/models/message_models.dart';
import 'package:chat_app/util/chat_message.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List messages = [
    MessageModels(
      message: "Hey",
      sender: "101",
      receiver: "202",
      timestamp: DateTime(2000),
      isSeenByReceiver: false,
    ),
    MessageModels(
      message: "Hello",
      sender: "202",
      receiver: "101",
      timestamp: DateTime(2000),
      isSeenByReceiver: false,
    ),
    MessageModels(
      message: "How are you?",
      sender: "101",
      receiver: "202",
      timestamp: DateTime(2000),
      isSeenByReceiver: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 24,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ChatMessage(
              msg: messages[index],
              currentUser: "101",
              isImage: false,
            );
          }),
    );
  }
}

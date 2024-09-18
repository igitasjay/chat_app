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
      timestamp: DateTime(2024, 9, 16),
      isSeenByReceiver: true,
    ),
    MessageModels(
      message: "Hello",
      sender: "202",
      receiver: "101",
      timestamp: DateTime(2024, 9, 17),
      isSeenByReceiver: false,
    ),
    MessageModels(
      message: "How are you?",
      sender: "101",
      receiver: "202",
      timestamp: DateTime(2024, 9, 18),
      isSeenByReceiver: false,
    ),
    MessageModels(
      message: "How are you?",
      sender: "202",
      receiver: "101",
      timestamp: DateTime(2024, 9, 18),
      isSeenByReceiver: false,
      isImage: true,
    ),
  ];
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 24,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/400'),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatMessage(
                    msg: messages[index],
                    currentUser: "101",
                    isImage: true,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "type your message...",
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_a_photo),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send_rounded),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

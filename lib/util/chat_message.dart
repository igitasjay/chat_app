import 'package:chat_app/models/message_models.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  final MessageModels msg;
  final String currentUser;
  final bool isImage;
  const ChatMessage({
    super.key,
    required this.msg,
    required this.currentUser,
    required this.isImage,
  });

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: widget.msg.sender == widget.currentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: widget.msg.sender == widget.currentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .75),
                    decoration: BoxDecoration(
                        color: widget.msg.sender == widget.currentUser
                            ? Colors.black
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          topRight: const Radius.circular(10),
                          bottomLeft: widget.msg.sender == widget.currentUser
                              ? const Radius.circular(10)
                              : const Radius.circular(2),
                          bottomRight: widget.msg.sender == widget.currentUser
                              ? const Radius.circular(2)
                              : const Radius.circular(10),
                        )),
                    child: Text(
                      widget.msg.message,
                      style: TextStyle(
                        color: widget.msg.sender == widget.currentUser
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/models/message_models.dart';
import 'package:chat_app/util/format_datetime.dart';
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
    return widget.isImage
        ? Container(
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
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: "https://i.pravatar.cc/300",
                          height: MediaQuery.of(context).size.height * .3,
                          width: MediaQuery.of(context).size.width * .75,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formatDate(widget.msg.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(width: 4),
                        widget.msg.sender == widget.currentUser
                            ? widget.msg.isSeenByReceiver
                                ? const Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: Colors.grey,
                                  )
                            : const SizedBox(),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        : Padding(
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
                              maxWidth:
                                  MediaQuery.of(context).size.width * .75),
                          decoration: BoxDecoration(
                              color: widget.msg.sender == widget.currentUser
                                  ? Colors.black
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10),
                                topRight: const Radius.circular(10),
                                bottomLeft:
                                    widget.msg.sender == widget.currentUser
                                        ? const Radius.circular(10)
                                        : const Radius.circular(2),
                                bottomRight:
                                    widget.msg.sender == widget.currentUser
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
                    ),
                    Row(
                      children: [
                        Text(
                          formatDate(widget.msg.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(width: 4),
                        widget.msg.sender == widget.currentUser
                            ? widget.msg.isSeenByReceiver
                                ? const Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: Colors.grey,
                                  )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
  }
}

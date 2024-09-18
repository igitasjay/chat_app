class MessageModels {
  final String message;
  final String sender;
  final String receiver;
  final String? messadeID;
  final DateTime timestamp;
  final bool isSeenByReceiver;
  final bool? isImage;

  MessageModels({
    required this.message,
    required this.sender,
    required this.receiver,
    this.messadeID,
    required this.timestamp,
    required this.isSeenByReceiver,
    this.isImage,
  });
}

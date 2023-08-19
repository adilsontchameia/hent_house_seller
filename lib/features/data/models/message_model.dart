import '../../presentation/filtered_advertisiment/filtered_advertisiment.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime date;
  final String messageId;
  final bool isSeen;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.date,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'date': date != null ? Timestamp.fromDate(date) : null,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    Timestamp? timestamp = map['date'] as Timestamp?;
    DateTime? timeSentDateTime = timestamp?.toDate();

    return MessageModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      message: map['message'] ?? '',
      date: timeSentDateTime!,
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}

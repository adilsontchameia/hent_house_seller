import '../../presentation/filtered_advertisiment/filtered_advertisiment.dart';

class ChatContact {
  final String? name;
  final String? profilePic;
  final String? contactId;
  final DateTime? timeSent;
  final String? lastMessage;

  ChatContact({
    this.name,
    this.profilePic,
    this.contactId,
    this.timeSent,
    this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent != null ? Timestamp.fromDate(timeSent!) : null,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    Timestamp? timestamp = map['timeSent'] as Timestamp?;
    DateTime? timeSentDateTime = timestamp?.toDate();

    return ChatContact(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      contactId: map['contactId'] as String,
      timeSent: timeSentDateTime,
      lastMessage: map['lastMessage'] as String,
    );
  }
}

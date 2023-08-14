import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hent_house_seller/features/presentation/home_screen/home.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/factories/dialogs.dart';

class ChatService extends ChangeNotifier {
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;
  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();

  ChatService() {
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
  }

  void sendTextMessage({
    required String message,
    required String userId,
  }) async {
    try {
      final timeSent = DateTime.now();
      final currentId = auth.currentUser!.uid;
      final messageId = const Uuid().v1();
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(userId)
          .collection('chats')
          .add({
        'senderId': currentId,
        'receiverId': userId,
        'messageId': messageId,
        'message': message,
        'date': timeSent,
        'isSeen': false,
      });

      // Update last message for the seller
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(currentId)
          .set({
        'lastMessage': message,
        'lastMessageDate': timeSent,
      });

      //_ User who we are talking to
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(currentId)
          .collection('chats')
          .add({
        'senderId': currentId,
        'receiverId': userId,
        'message': message,
        'messageId': messageId,
        'date': timeSent,
        'isSeen': false,
      });

      // Update last message for the current user
      await FirebaseFirestore.instance.collection('messages').doc(userId).set({
        'lastMessage': message,
        'lastMessageDate': timeSent,
      });
    } catch (e) {
      _dialogs.showToastMessage(e.toString());
    }
  }

  Future<void> setChatMessageSeen(String userId, String messageId) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final chatDocRef = FirebaseFirestore.instance
            .collection('messages')
            .doc(userId)
            .collection('chats')
            .doc(messageId);

        final chatSnapshot = await transaction.get(chatDocRef);

        if (chatSnapshot.exists) {
          if (!chatSnapshot.data()!['isSeen']) {
            transaction.update(chatDocRef, {'isSeen': true});
          }
        }
      });
    } catch (e) {
      log('Error updating isSeen: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatsMessage(
      String sellerId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(sellerId)
        .collection('chats')
        .orderBy(
          'date',
          descending: false,
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listAllChatsMessage() {
    return FirebaseFirestore.instance.collection('messages').snapshots();
  }

  Future<Map<String, dynamic>> getLastMessage(String chatId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('messages')
          .doc(chatId)
          .get();

      if (querySnapshot.exists) {
        final lastMessage = querySnapshot.data()!;
        final timestamp = lastMessage['lastMessageDate'] as Timestamp;

        final dateTime =
            DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);

        final formattedTime = DateFormat('HH:mm').format(dateTime);

        return {
          'lastMessage': lastMessage['lastMessage'],
          'lastMessageDate': formattedTime,
        };
      } else {
        return {
          'lastMessage': '',
          'lastMessageDate': null,
        };
      }
    } catch (e) {
      print('Error fetching last message: $e');
      return {
        'lastMessage': '',
        'lastMessageDate': null,
      };
    }
  }
}

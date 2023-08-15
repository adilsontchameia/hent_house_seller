import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:hent_house_seller/features/data/models/message_model.dart';
import 'package:hent_house_seller/features/presentation/chat_messages/widgets/my_message.dart';
import 'package:hent_house_seller/features/presentation/chat_messages/widgets/sender_message.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:hent_house_seller/features/services/chat_service.dart';
import 'package:intl/intl.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final ScrollController messageController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getAllChatsMessage(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Diz Olá !'),
          );
        } else {
          final messages = snapshot.data!.docs
              .map((doc) =>
                  MessageModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          //? Autoscroll on new message
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/home_view.jpg',
                  fit: BoxFit.fitHeight,
                  height: height,
                ),
              ),
              ListView.builder(
                itemCount: messages.length,
                controller: messageController,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == _authService.getUser().uid;

                  if (!message.isSeen &&
                      message.receiverId == _authService.getUser().uid) {
                    _chatService.setChatMessageSeen(
                      message.receiverId,
                      message.messageId,
                    );
                  }

                  String formattedDate = DateFormat.jm().format(message.date);
                  if (isMe) {
                    return MyMessageCard(
                      message: message.message,
                      date: formattedDate,
                      isSeen: message.isSeen,
                    );
                  } else {
                    return SenderMessageCard(
                      message: message.message,
                      date: formattedDate,
                    );
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }
}

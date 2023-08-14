import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/presentation/list_chat_messages/widgets/last_messages_chat_widget.dart';

class ListChatMessagesScreen extends StatelessWidget {
  static const routeName = '/chat-messages-list';

  const ListChatMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CHAT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                    letterSpacing: 2,
                    color: Colors.brown,
                  ),
                ),
                LastMessagesChatWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

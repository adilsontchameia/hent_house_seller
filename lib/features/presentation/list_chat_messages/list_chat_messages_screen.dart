import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hent_house_seller/features/services/auth_service.dart';
import 'package:hent_house_seller/features/services/chat_service.dart';

class ListChatMessagesScreen extends StatelessWidget {
  static const routeName = '/chat-messages-list';

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  ListChatMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<QueryDocumentSnapshot> documents =
                          snapshot.data!.docs;

                      final filteredUIDs = documents
                          .map((doc) => doc.id)
                          .where((uid) => uid != _authService.getUser().uid)
                          .toList();

                      return SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: filteredUIDs.length,
                          itemBuilder: (context, index) {
                            final uid = filteredUIDs[index];

                            return ListTile(
                              title: Text(uid),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

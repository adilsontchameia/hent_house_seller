import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/data/models/chat_contact_model.dart';
import 'package:hent_house_seller/features/services/chat_service.dart';
import 'package:intl/intl.dart';

import '../../../services/auth_service.dart';
import '../../chat_messages/chat_messages_screen.dart';
import '../../filtered_advertisiment/filtered_advertisiment.dart';
import '../../widgets/circular_on_fetching.dart';

class LastMessagesChatWidget extends StatelessWidget {
  LastMessagesChatWidget({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.listAllChatsMessage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //? Filtering to skip current user UID
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          final currentUserUid = _authService.getUser().uid;
          final filteredUIDs = documents
              .map((doc) => doc.id)
              .where((uid) => uid != currentUserUid)
              .toList();
          return SizedBox(
            height: 200.0,
            child: ListView.builder(
              itemCount: filteredUIDs.length,
              itemBuilder: (context, index) {
                final uid = filteredUIDs[index];

                log('Name: $uid');
                // Create a ValueNotifier for each chat contact
                final ValueNotifier<ChatContact> chatContactNotifier =
                    ValueNotifier<ChatContact>(ChatContact());

                // Fetch the chat contact and update the notifier
                _chatService.getLastMessage(uid).then((chatContact) {
                  chatContactNotifier.value = chatContact;
                });

                return ValueListenableBuilder<ChatContact>(
                  valueListenable: chatContactNotifier,
                  builder: (context, chatContact, child) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    final now = DateTime.now();

                    String formattedDate =
                        DateFormat.jm().format(chatContact.timeSent ?? now);

                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        ChatMessagesScreen.routeName,
                        arguments: {
                          'name': chatContact.name,
                          'uid': uid,
                        },
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(80.0),
                              child: CachedNetworkImage(
                                imageUrl: chatContact.profilePic ?? '',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressOnFecthing(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const CircularProgressOnFecthing(),
                                fit: BoxFit.fill,
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chatContact.name ?? 'Carregado...',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        chatContact.lastMessage ?? '',
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
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
    );
  }
}

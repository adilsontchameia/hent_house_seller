import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hent_house_seller/features/presentation/chat_messages/widgets/bottom_chat_field.dart';
import 'package:hent_house_seller/features/presentation/chat_messages/widgets/chat_list.dart';
import 'package:hent_house_seller/features/presentation/providers/user_data_provider.dart';
import 'package:hent_house_seller/features/presentation/widgets/error_icon_on_fetching.dart';
import 'package:hent_house_seller/features/services/user_manager.dart';

import '../home_screen/home.dart';

class ChatMessagesScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  const ChatMessagesScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);
  final String name;
  final String uid;
  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  UserDataProvider userDataProvider = UserDataProvider();
  final UserManager _userManager = UserManager();

  Future<void> fetchCurrentUser() async {
    await userDataProvider.getCurrentUserData();

    log('User found');
    log(userDataProvider.currentUser.fullName!);
  }

  @override
  void initState() {
    super.initState();

    fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 212, 212),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.brown),
        title: StreamBuilder(
            stream: _userManager.getSellerById(widget.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!.image!,
                      fit: BoxFit.fill,
                      height: 30.0,
                      width: 30.0,
                      placeholder: (context, str) => Center(
                        child: Container(
                            color: Colors.white,
                            height: height,
                            width: width,
                            child: Image.asset('assets/loading.gif')),
                      ),
                      errorWidget: (context, url, error) =>
                          const ErrorIconOnFetching(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('clients')
                            .doc(widget.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final isTyping =
                                snapshot.data?.get('isTyping') ?? false;
                            final status = snapshot.data?.get('isOnline')
                                ? 'Online'
                                : 'Offline';

                            return Text(
                              isTyping ? 'Escrevendo...' : status,
                              style: TextStyle(
                                color: isTyping ? Colors.green : Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            );
                          }

                          return const SizedBox(); // Handle loading/error state
                        },
                      )
                    ],
                  )
                ],
              );
            }),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(userId: widget.uid),
          ),
          BottomChatField(
            receiverId: widget.uid,
            currentUserData: userDataProvider.currentUser,
          ),
        ],
      ),
    );
  }
}

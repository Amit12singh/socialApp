import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/page-1/feeds/postScreen.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:page_transition/page_transition.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key});

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final HandleToken localStorageService = HandleToken();
  final ChatService _chatService = ChatService();

  List chatItems = [];

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    final user = await localStorageService.getUser();

    final _data = await _chatService.recentChat(userId: user?.id);
    setState(() {
      chatItems = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          const Text(
            'Recent Messages',
            style: TextStyle(
              color: Color.fromARGB(255, 167, 135, 135),
              decoration: TextDecoration.none,
              fontFamily: 'PermanentMarker-Regular',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Divider(
            color: Color.fromARGB(40, 167, 135, 135),
            height: 20,
            thickness: 3,
          ),
          Container(
              width: double.infinity,
              child: ListView.builder(
                itemCount: chatItems.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  ChatModel chatItem = chatItems[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.scale,
                          alignment: Alignment.bottomCenter,
                          child: ChatScreen(receiver: chatItems[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 26.0, top: 20, right: 10),
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              chatItem.avatarImage != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          chatItem.avatarImage ?? ''),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/page-1/images/ellipse-1-bg-Ztm.png'),
                                    ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    chatItem.name,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 18, 16, 16),
                                      fontFamily: 'Quicksand',
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    chatItem.time ?? '',
                                    style: const TextStyle(
                                      color: Color.fromARGB(179, 17, 16, 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                chatItem.text ?? '',
                                style: const TextStyle(
                                  color: Color.fromARGB(179, 18, 17, 17),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}

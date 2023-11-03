import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/page-1/ChatScreen.dart';
import 'package:myapp/page-1/feeds/bottombar.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/page-1/feeds/post.dart';
import 'package:myapp/services/chat_service.dart';
import 'package:myapp/utilities/localstorage.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key});

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final HandleToken localStorageService = HandleToken();
  final ChatService _chatService = ChatService();

  List chatItems = [
    // Add more chat items as needed
  ];

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
          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, right: 15),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text(
          //             'Messages',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontFamily: 'Quicksand',
          //                 fontSize: 30,
          //                 color: Colors.white),
          //           ),
          //           IconButton(
          //             onPressed: () {},
          //             icon: const Icon(
          //               Icons.search,
          //               color: Colors.white,
          //               size: 36,
          //             ),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       const Text(
          //         'R E C E N T',
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Container(
              //   height: 645.6,
              width: double.infinity,
              // decoration: const BoxDecoration(
              //   color: Color.fromARGB(255, 229, 230, 232),
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(50),
              //     topRight: Radius.circular(50),
              //   ),
              // ),
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
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(receiver: chatItems[index]),
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
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(chatItem.avatarImage ?? ''),
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

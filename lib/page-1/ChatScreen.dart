import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.101.7:8000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    // socket.emit("signin", widget.sourchat.id);
    socket.onConnect((data) {
      print("Connected $data");
      socket.on("message", (msg) {
        print(msg);
        // setMessage("destination", msg["message"]);
        // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        // duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print("socket");

    print(socket);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        Image.asset('assets/page-1/images/rectangle-688.png')
                            .image,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Danny Hopkins',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: ('Quicksand'),
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.white70,
                    size: 40,
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  '1 FEB 12:00',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff373E4E)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'I commented on Figma, I want to add \n some fancy icons. Do you have any icon \n set?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 115.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff7A8194)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'I commented on Figma, I want to add \n some fancy icons.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff373E4E)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Next Month?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  '08:12',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff7A8194)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'I am almost finish. Please give me your \n email, I will Zip them and send you as soon\n as im finish.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 340.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff7A8194)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  '08:43',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff373E4E)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'amitkumarkushwaha445@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 300.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff7A8194)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'thums up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff304354),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Message',
                        style: TextStyle(color: Colors.white54),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

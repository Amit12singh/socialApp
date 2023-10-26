import 'package:flutter/material.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  HandleToken localStorageService = HandleToken();
  late IO.Socket socket;
  String? token;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    token = await localStorageService.getAccessToken();
    print(token);

    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.101.7:8000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "query": {"token": token}
    });
    socket.connect();
    socket.emit("joinRoom", "1");
    socket.on('message', (data) {
      print('Received: $data');
    });
    socket.onConnect((data) {
      print("Connected $data");
    });

    print(socket.connected);
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void sendMessage(String message) {
    socket.emit('messageToRoom', {
      'receiverID': '2', // Replace with the actual recipient ID
      'text': message,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 169, 145, 36),
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/page-1/images/rectangle-688.png'),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Danny Hopkins',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.search_rounded,
                      color: Colors.white70,
                      size: 40,
                    )
                  ],
                ),
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
                  color: Color(0xff373E4E),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                  color: Color(0xff373E4E),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
              SizedBox(height: 10),
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
                padding: const EdgeInsets.only(left: 320.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff7A8194),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '👍',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff304354),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here',
                                    hintStyle: TextStyle(color: Colors.white54),
                                  ),
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () =>
                                    sendMessage('Hello from Flutter!'),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white54,
                                ),
                                backgroundColor: Colors
                                    .transparent, // Set your desired button background color
                                elevation:
                                    0, // Remove elevation for a flat appearance
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50.0), // Adjust the radius to make it circular
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Other widgets can be added here
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

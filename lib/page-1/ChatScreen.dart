import 'package:flutter/material.dart';
import 'package:myapp/models/chat_model.dart';
import 'package:myapp/utilities/localstorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:myapp/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel receiver;
  const ChatScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  HandleToken localStorageService = HandleToken();
  late IO.Socket socket;
  String? token;
  UserModel? _user;
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    token = await localStorageService.getAccessToken();
    final currentUser = await HandleToken().getUser();
    setState(() {
      _user = currentUser;
    });

    print(token);

    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.101.7:8000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "query": {"token": token}
    });
    socket.connect();
    // socket.emit("joinRoom", );
    socket.onConnect((data) {
      print("Connected");

      socket.on('message', (msg) => {print('response $msg')});
    });

    print(socket.connected);
  }

  @override
  void dispose() {
    socket.disconnect();
    messageController.dispose();
    super.dispose();
  }

  // void sendMessage(String message) {
  //   socket.emit('messageToRoom', {
  //     'receiverID': '1', // Replace with the actual recipient ID
  //     'text': message,
  //   });
  // }

  List<types.Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 169, 145, 36),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Row(
                children: [
                  widget.receiver.avatarImage != null
                      ?
                  CircleAvatar(
                          radius: 25,
                          backgroundImage:
                    
                              NetworkImage(widget.receiver.avatarImage ?? ''))
                      : const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              'assets/page-1/images/logo-3-removebg-preview-1.png'),
                        ),
                  const SizedBox(width: 10),
                  Text(
                    widget.receiver.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Quicksand',
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
            ),
            Expanded(
              child: Chat(
                messages: _messages,
                onSendPressed: _handleSendPressed,
                user: types.User(id: _user?.id ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(id: _user?.id ?? ''),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "id",
      text: message.text,
    );
    socket.emit('messageToRoom', {
      'receiverID': widget.receiver.id, // Replace with the actual recipient ID
      'text': message.text,
    });
    _addMessage(textMessage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }
}

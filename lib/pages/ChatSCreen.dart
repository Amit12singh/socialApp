import 'package:flutter/material.dart';
import 'package:ppsona/models/chat_model.dart';
import 'package:ppsona/models/user_model.dart';
import 'package:ppsona/services/chat_service.dart';
import 'package:ppsona/utilities/LocalStorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:async';

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
  final ChatService chatService = ChatService();
  final List<types.Message> _messages = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    connect();
    startMessagePolling();
  }

  void startMessagePolling() {
    const pollingInterval = Duration(seconds: 2);

    _timer = Timer.periodic(pollingInterval, (timer) async {
      final newMessages =
          await chatService.lastChats(sender: widget.receiver.id);

      if (newMessages.isNotEmpty) {
        _addMessages(newMessages);
      }
    });
  }

  void stopMessagePolling() {
    _timer?.cancel();
  }

  void connect() async {
    token = await localStorageService.getAccessToken();
    final currentUser = await HandleToken().getUser();
    final List<types.TextMessage> messages = await chatService.allChats(
        sender: currentUser?.id, receiver: widget.receiver.id);
    _addMessages(messages);
    setState(() {
      _user = currentUser;
    });

    socket = IO.io(
        "https://apis.oldnabhaite.site/oldnabhaiteapis:8080", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "query": {"token": token}
    });
    socket.connect();
    socket.emit(
      "joinRoom",
    );
    socket.onConnect((data) {});

    socket.on('message', (msg) {
      addReceivedMessage(msg);
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    messageController.dispose();
    stopMessagePolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 167, 135, 135),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Row(
                children: [
                  widget.receiver.avatarImage != null
                      ? CircleAvatar(
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
                      fontFamily: 'PermanentMarker-Regular',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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

    _addMessages([textMessage]);
    chatService.sendMessage(message.text, widget.receiver.id);
  }

  void addReceivedMessage(String message) {
    final receivedMessage = types.TextMessage(
      author:
          types.User(id: widget.receiver.id), // Set the receiver as the author
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: UniqueKey().toString(),
      text: message,
    );
    _addMessages([receivedMessage]);
  }

  void _addMessages(List<types.Message> messages) {
    setState(() {
      _messages.insertAll(0, messages);
    });
  }
}

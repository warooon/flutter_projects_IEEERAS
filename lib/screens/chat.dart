import 'package:chat_app/widget/chat_message.dart';
import 'package:chat_app/widget/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void pusnotifications() async {
    final message = FirebaseMessaging.instance;
    await message.requestPermission();

    final token = await message.getToken();
    print(token);

    message.subscribeToTopic("chat");
  }

  @override
  void initState() {
    super.initState();
    pusnotifications();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterChat'),
          actions: [
            IconButton(
                onPressed: () async {
                  return await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [Expanded(child: ChatMessage()), NewMessage()],
        ));
  }
}

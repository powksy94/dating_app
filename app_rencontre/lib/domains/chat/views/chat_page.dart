import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String chatId;
  const ChatPage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MESSAGES')),
      body: const Center(
        child: Text(
          'Chat à venir...',
          style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChatEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String sub;
  const ChatEmptyState({super.key, required this.icon, required this.message, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: const Color(0xFF7B00D4)),
          const SizedBox(height: 16),
          Text(message,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16)),
          const SizedBox(height: 8),
          Text(sub,
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13)),
        ],
      ),
    );
  }
}

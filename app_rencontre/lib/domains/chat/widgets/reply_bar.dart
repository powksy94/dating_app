import 'package:flutter/material.dart';
import 'package:nocturne/domains/chat/models/message.dart';

class ReplyBar extends StatelessWidget {
  final Message      replyingTo;
  final VoidCallback onCancel;

  const ReplyBar({
    super.key,
    required this.replyingTo,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF120018),
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
      child: Row(
        children: [
          const Icon(Icons.reply, size: 16, color: Color(0xFF7B00D4)),
          const SizedBox(width: 8),
          Container(width: 3, height: 32, color: const Color(0xFF7B00D4)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              replyingTo.isImage ? '📷 Photo' : replyingTo.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16, color: Color(0xFF5A4A6A)),
            onPressed: onCancel,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

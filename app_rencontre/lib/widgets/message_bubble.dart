import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message  message;
  final bool     isMe;
  final void Function(Message, bool isMe)? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => onLongPress?.call(message, isMe),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72,
          ),
          decoration: BoxDecoration(
            color: message.deletedForAll
                ? const Color(0xFF0D0010)
                : isMe
                    ? const Color(0xFF4A0072)
                    : const Color(0xFF1A0A1F),
            borderRadius: BorderRadius.only(
              topLeft:     const Radius.circular(18),
              topRight:    const Radius.circular(18),
              bottomLeft:  Radius.circular(isMe ? 18 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 18),
            ),
            border: Border.all(
              color: message.deletedForAll
                  ? const Color(0xFF2D0040)
                  : isMe
                      ? Colors.transparent
                      : const Color(0xFF2D0040),
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              message.deletedForAll
                  ? const Text(
                      'Message supprimé',
                      style: TextStyle(
                          color: Color(0xFF5A4A6A),
                          fontSize: 14,
                          fontStyle: FontStyle.italic),
                    )
                  : Text(
                      message.text,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15),
                    ),
              const SizedBox(height: 4),
              Text(
                _formatTime(message.createdAt),
                style: const TextStyle(
                    color: Color(0xFFAA9AB5), fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

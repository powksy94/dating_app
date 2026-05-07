import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController ctrl;
  final VoidCallback onSend;
  final void Function(String)? onChanged;
  const ChatInputBar({super.key, required this.ctrl, required this.onSend, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: const Color(0xFF120018),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: ctrl,
                style: const TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
                  filled: true,
                  fillColor: const Color(0xFF1A0A1F),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: onChanged,
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onSend,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF7B00D4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

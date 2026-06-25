import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController ctrl;
  final VoidCallback onSend;
  final VoidCallback? onImagePick;
  final VoidCallback? onMicPress;
  final VoidCallback? onMicCancel;
  final bool          isRecording;
  final void Function(String)? onChanged;

  const ChatInputBar({
    super.key,
    required this.ctrl,
    required this.onSend,
    this.onImagePick,
    this.onMicPress,
    this.onMicCancel,
    this.isRecording = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: const Color(0xFF120018),
        child: Row(
          children: [
            GestureDetector(
              onTap: onImagePick,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A0A1F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image_outlined,
                    color: Color(0xFF5A4A6A), size: 20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: ctrl,
                style: const TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.chatInputHint,
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
            if (isRecording)
              GestureDetector(
                onTap: onMicCancel,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B0000),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.delete_outline,
                      color: Colors.white, size: 20),
                ),
              ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onMicPress,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isRecording
                      ? const Color(0xFF8B0000)
                      : const Color(0xFF1A0A1F),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isRecording ? Icons.stop : Icons.mic_outlined,
                  color: isRecording
                      ? Colors.white
                      : const Color(0xFF5A4A6A),
                  size: 20,
                ),
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

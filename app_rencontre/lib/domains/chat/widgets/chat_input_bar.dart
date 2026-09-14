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
            _CircleIconButton(
              onTap: onImagePick,
              color: const Color(0xFF1A0A1F),
              icon: Icons.image_outlined,
              iconColor: const Color(0xFF5A4A6A),
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
              _CircleIconButton(
                onTap: onMicCancel,
                color: const Color(0xFF8B0000),
                icon: Icons.delete_outline,
                iconColor: Colors.white,
              ),
            const SizedBox(width: 6),
            _CircleIconButton(
              onTap: onMicPress,
              color: isRecording ? const Color(0xFF8B0000) : const Color(0xFF1A0A1F),
              icon: isRecording ? Icons.stop : Icons.mic_outlined,
              iconColor: isRecording ? Colors.white : const Color(0xFF5A4A6A),
            ),
            const SizedBox(width: 8),
            _CircleIconButton(
              onTap: onSend,
              color: const Color(0xFF7B00D4),
              icon: Icons.send,
              iconColor: Colors.white,
              padding: 12,
              iconSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final double padding;
  final double iconSize;

  const _CircleIconButton({
    required this.onTap,
    required this.color,
    required this.icon,
    required this.iconColor,
    this.padding = 10,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(icon, color: iconColor, size: iconSize),
        ),
      ),
    );
  }
}

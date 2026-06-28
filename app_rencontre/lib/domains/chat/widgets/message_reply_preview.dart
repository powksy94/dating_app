import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/models/message.dart';

class MessageReplyPreview extends StatelessWidget {
  final ReplyTo reply;
  const MessageReplyPreview({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2D0040),
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: Color(0xFF7B00D4), width: 3),
        ),
      ),
      child: reply.isImage
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.image_outlined, size: 14, color: Color(0xFF5A4A6A)),
                const SizedBox(width: 4),
                Text(AppLocalizations.of(context)!.chatReplyPhoto, style: const TextStyle(
                    color: Color(0xFF5A4A6A), fontSize: 12)),
              ],
            )
          : Text(
              reply.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Color(0xFF5A4A6A), fontSize: 12),
            ),
    );
  }
}

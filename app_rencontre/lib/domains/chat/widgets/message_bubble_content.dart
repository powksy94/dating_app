import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/domains/chat/widgets/audio_player_bubble.dart';
import 'package:nocturne/domains/chat/widgets/message_status_row.dart';

class MessageBubbleContent extends StatelessWidget {
  final Message message;
  final bool    isMe;
  final bool    showReadReceipt;
  final String? otherId;

  const MessageBubbleContent({
    super.key,
    required this.message,
    required this.isMe,
    required this.showReadReceipt,
    this.otherId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (message.deletedForAll)
            Text(AppLocalizations.of(context)!.chatMessageDeleted,
                style: const TextStyle(
                    color: Color(0xFF5A4A6A),
                    fontSize: 14,
                    fontStyle: FontStyle.italic))
          else if (message.isAudio)
            AudioPlayerBubble(
              audioUrl: message.audioUrl!,
              isMe:     isMe,
            )
          else if (message.isImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                message.imageUrl!,
                width: 200,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : const SizedBox(
                        width: 200, height: 120,
                        child: Center(
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF7B00D4)),
                        )),
              ),
            )
          else if (message.text.isNotEmpty)
            Text(message.text,
                style: const TextStyle(color: Colors.white, fontSize: 15))
          else
            const SizedBox.shrink(),
          const SizedBox(height: 4),
          MessageStatusRow(
            createdAt:       message.createdAt,
            isMe:            isMe,
            showReadReceipt: showReadReceipt,
            isRead:          otherId != null && message.isReadBy(otherId!),
            deletedForAll:   message.deletedForAll,
          ),
        ],
      ),
    );
  }
}

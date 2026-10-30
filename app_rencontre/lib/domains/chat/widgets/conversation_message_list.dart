import 'package:flutter/material.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/domains/chat/widgets/message_bubble.dart';
import 'package:nocturne/domains/chat/widgets/message_options_sheet.dart';
import 'package:nocturne/domains/chat/widgets/conversation_starters.dart';
import 'package:nocturne/domains/social/widgets/report_flow.dart';

/// The conversation's main content: either the conversation-starter prompts
/// (no messages yet) or the scrollable message list, each bubble wired to
/// its long-press menu (react, delete, report).
class ConversationMessageList extends StatelessWidget {
  final List<Message> messages;
  final String? myId;
  final ChatMatch match;
  final ScrollController scrollController;
  final void Function(String text) onSendStarter;
  final void Function(Message message) onSwipeReply;
  final void Function(String messageId, String emoji) onReact;
  final void Function(Message message) onDeleteForMe;
  final void Function(Message message) onDeleteForAll;
  final void Function(String messageId) onMessageReported;

  const ConversationMessageList({
    super.key,
    required this.messages,
    required this.myId,
    required this.match,
    required this.scrollController,
    required this.onSendStarter,
    required this.onSwipeReply,
    required this.onReact,
    required this.onDeleteForMe,
    required this.onDeleteForAll,
    required this.onMessageReported,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return ConversationStarters(matchId: match.matchId, onSend: onSendStarter);
    }
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (context, i) {
        final msg        = messages[i];
        final isMe        = msg.sender == myId;
        final isLastMine = isMe && messages.lastIndexWhere((m) => m.sender == myId) == i;
        return MessageBubble(
          message:         msg,
          isMe:            isMe,
          showReadReceipt: isLastMine,
          otherId:         match.userId,
          onSwipeReply:    onSwipeReply,
          onLongPress:     (m, me) => showMessageOptionsSheet(
            context, m, me,
            onReact:        (emoji) => onReact(m.id, emoji),
            onDeleteForMe:  () => onDeleteForMe(m),
            onDeleteForAll: () => onDeleteForAll(m),
            onReport:       me ? null : () => showReportFlow(
              context,
              userId:    match.userId,
              username:  match.username,
              messageId: m.id,
              messageSnapshot: m.text,
              onReported: () => onMessageReported(m.id),
            ),
          ),
        );
      },
    );
  }
}

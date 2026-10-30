import 'package:flutter/material.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/domains/chat/utils/last_seen_text.dart';
import 'package:nocturne/domains/chat/widgets/chat_app_bar.dart';
import 'package:nocturne/domains/chat/widgets/chat_input_bar.dart';
import 'package:nocturne/domains/chat/widgets/reply_bar.dart';
import 'package:nocturne/domains/chat/widgets/conversation_message_list.dart';

/// The conversation screen's visual structure (app bar, message list, reply
/// bar, input bar) — purely presentational, every piece of state and every
/// action it needs comes in as a parameter.
class ConversationScaffold extends StatelessWidget {
  final ChatMatch match;
  final bool loading;
  final List<Message> messages;
  final String? myId;
  final bool otherOnline;
  final bool otherTyping;
  final DateTime? otherLastSeen;
  final Message? replyingTo;
  final bool isRecording;
  final ScrollController scrollController;
  final TextEditingController textController;

  final void Function(String text) onSendStarter;
  final void Function(Message message) onSwipeReply;
  final void Function(String messageId, String emoji) onReact;
  final void Function(Message message) onDeleteForMe;
  final void Function(Message message) onDeleteForAll;
  final void Function(String messageId) onMessageReported;
  final VoidCallback onCancelReply;
  final VoidCallback onSend;
  final VoidCallback onImagePick;
  final VoidCallback onMicPress;
  final VoidCallback onMicCancel;
  final void Function(String) onTextChanged;

  const ConversationScaffold({
    super.key,
    required this.match,
    required this.loading,
    required this.messages,
    required this.myId,
    required this.otherOnline,
    required this.otherTyping,
    required this.otherLastSeen,
    required this.replyingTo,
    required this.isRecording,
    required this.scrollController,
    required this.textController,
    required this.onSendStarter,
    required this.onSwipeReply,
    required this.onReact,
    required this.onDeleteForMe,
    required this.onDeleteForAll,
    required this.onMessageReported,
    required this.onCancelReply,
    required this.onSend,
    required this.onImagePick,
    required this.onMicPress,
    required this.onMicCancel,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: ChatAppBar(
        match:        match,
        otherOnline:  otherOnline,
        otherTyping:  otherTyping,
        lastSeenText: otherOnline ? null : formatLastSeenText(context, otherLastSeen),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ConversationMessageList(
                    messages:        messages,
                    myId:            myId,
                    match:           match,
                    scrollController: scrollController,
                    onSendStarter:   onSendStarter,
                    onSwipeReply:    onSwipeReply,
                    onReact:         onReact,
                    onDeleteForMe:   onDeleteForMe,
                    onDeleteForAll:  onDeleteForAll,
                    onMessageReported: onMessageReported,
                  ),
                ),
                if (replyingTo != null)
                  ReplyBar(
                    replyingTo: replyingTo!,
                    onCancel:   onCancelReply,
                  ),
                ChatInputBar(
                  ctrl:        textController,
                  onSend:      onSend,
                  onImagePick: onImagePick,
                  onMicPress:  onMicPress,
                  onMicCancel: onMicCancel,
                  isRecording: isRecording,
                  onChanged:   onTextChanged,
                ),
              ],
            ),
    );
  }
}

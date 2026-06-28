import 'package:flutter/material.dart';
import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/domains/chat/widgets/message_bubble_content.dart';
import 'package:nocturne/domains/chat/widgets/message_reactions_row.dart';
import 'package:nocturne/domains/chat/widgets/message_reply_preview.dart';

class MessageBubble extends StatefulWidget {
  final Message  message;
  final bool     isMe;
  final bool     showReadReceipt;
  final String?  otherId;
  final void Function(Message, bool isMe)? onLongPress;
  final void Function(Message)?            onSwipeReply;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.showReadReceipt = false,
    this.otherId,
    this.onLongPress,
    this.onSwipeReply,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double _dragOffset = 0;
  bool   _triggered  = false;

  void _onHorizontalDragUpdate(DragUpdateDetails d) {
    if (d.delta.dx > 0) {
      setState(() => _dragOffset = (_dragOffset + d.delta.dx).clamp(0, 64));
    }
  }

  void _onHorizontalDragEnd(DragEndDetails _) {
    if (_dragOffset >= 48 && !_triggered) {
      _triggered = true;
      widget.onSwipeReply?.call(widget.message);
    }
    setState(() { _dragOffset = 0; _triggered = false; });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => widget.onLongPress?.call(widget.message, widget.isMe),
      onHorizontalDragUpdate: widget.onSwipeReply != null
          ? _onHorizontalDragUpdate
          : null,
      onHorizontalDragEnd: widget.onSwipeReply != null
          ? _onHorizontalDragEnd
          : null,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(left: _dragOffset),
        child: Stack(
          children: [
            Align(
              alignment: widget.isMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (widget.message.replyTo != null)
                    MessageReplyPreview(reply: widget.message.replyTo!),
                  MessageBubbleContent(
                    message:         widget.message,
                    isMe:            widget.isMe,
                    showReadReceipt: widget.showReadReceipt,
                    otherId:         widget.otherId,
                  ),
                  if (widget.message.reactions.isNotEmpty)
                    MessageReactionsRow(reactions: widget.message.reactions),
                ],
              ),
            ),
            if (_dragOffset > 16)
              Positioned(
                left: 0,
                top: 0, bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: (_dragOffset / 48).clamp(0, 1),
                    duration: const Duration(milliseconds: 100),
                    child: const Icon(Icons.reply,
                        color: Color(0xFF7B00D4), size: 20),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

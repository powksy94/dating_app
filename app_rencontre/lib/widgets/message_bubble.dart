import 'package:flutter/material.dart';
import '../models/message.dart';
import 'chat/audio_player_bubble.dart';

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
                    _replyPreview(widget.message.replyTo!),
                  _bubble(),
                  if (widget.message.reactions.isNotEmpty)
                    _reactionsRow(),
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

  Widget _reactionsRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Wrap(
        spacing: 4,
        children: widget.message.reactions.entries.map((e) {
          final emoji = e.key;
          final count = e.value.length;
          if (count == 0) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF2D0040),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF3D2A4A)),
            ),
            child: Text('$emoji $count',
                style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
      ),
    );
  }

  Widget _replyPreview(ReplyTo reply) {
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
          ? const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image_outlined, size: 14, color: Color(0xFF5A4A6A)),
                SizedBox(width: 4),
                Text('Photo', style: TextStyle(
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

  Widget _bubble() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.72,
      ),
      decoration: BoxDecoration(
        color: widget.message.deletedForAll
            ? const Color(0xFF0D0010)
            : widget.isMe
                ? const Color(0xFF4A0072)
                : const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.only(
          topLeft:     const Radius.circular(18),
          topRight:    const Radius.circular(18),
          bottomLeft:  Radius.circular(widget.isMe ? 18 : 4),
          bottomRight: Radius.circular(widget.isMe ? 4 : 18),
        ),
        border: Border.all(
          color: widget.message.deletedForAll
              ? const Color(0xFF2D0040)
              : widget.isMe
                  ? Colors.transparent
                  : const Color(0xFF2D0040),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: widget.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (widget.message.deletedForAll)
            const Text('Message supprimé',
                style: TextStyle(
                    color: Color(0xFF5A4A6A),
                    fontSize: 14,
                    fontStyle: FontStyle.italic))
          else if (widget.message.isAudio)
            AudioPlayerBubble(
              audioUrl: widget.message.audioUrl!,
              isMe:     widget.isMe,
            )
          else if (widget.message.isImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.message.imageUrl!,
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
          else if (widget.message.text.isNotEmpty)
            Text(widget.message.text,
                style: const TextStyle(color: Colors.white, fontSize: 15))
          else
            const SizedBox.shrink(),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_formatTime(widget.message.createdAt),
                  style: const TextStyle(
                      color: Color(0xFFAA9AB5), fontSize: 10)),
              if (widget.isMe && widget.showReadReceipt &&
                  !widget.message.deletedForAll) ...[
                const SizedBox(width: 4),
                Text(
                  widget.otherId != null &&
                          widget.message.isReadBy(widget.otherId!)
                      ? 'Lu'
                      : 'Envoyé',
                  style: TextStyle(
                    color: widget.otherId != null &&
                            widget.message.isReadBy(widget.otherId!)
                        ? const Color(0xFF7B00D4)
                        : const Color(0xFF5A4A6A),
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

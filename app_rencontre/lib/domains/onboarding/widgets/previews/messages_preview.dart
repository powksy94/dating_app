import 'package:flutter/material.dart';

/// A miniature of the real chat bubbles (message_bubble_content.dart): same
/// colors and same asymmetric corner radius (the "tail" corner stays sharp),
/// centered so nothing reaches the round bubble's clipped corners.
class MessagesPreview extends StatelessWidget {
  const MessagesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      child: Center(
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _bubble(lines: const [46, 28], color: const Color(0xFF1A0A1F), border: const Color(0xFF2D0040), isMe: false),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: _bubble(lines: const [40], color: const Color(0xFF4A0072), border: null, isMe: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bubble({required List<double> lines, required Color color, required Color? border, required bool isMe}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft:     const Radius.circular(14),
          topRight:    const Radius.circular(14),
          bottomLeft:  Radius.circular(isMe ? 14 : 3),
          bottomRight: Radius.circular(isMe ? 3 : 14),
        ),
        border: border != null ? Border.all(color: border, width: 0.8) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final w in lines) ...[
            Container(height: 6, width: w, decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(3))),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

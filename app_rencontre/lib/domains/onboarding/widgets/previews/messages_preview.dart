import 'package:flutter/material.dart';

/// Two chat bubbles, one of them styled like an elegy (bordered, italic-ish
/// line lengths), echoing the real conversation screen.
class MessagesPreview extends StatelessWidget {
  const MessagesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bubble(alignRight: false, lines: const [50, 30], color: const Color(0xFF2D0040), border: null),
          const SizedBox(height: 10),
          _bubble(
            alignRight: true,
            lines: const [60, 44, 34],
            color: const Color(0xFF1A0030),
            border: const Color(0xFF9D2FE8),
          ),
        ],
      ),
    );
  }

  Widget _bubble({required bool alignRight, required List<double> lines, required Color color, Color? border}) {
    return Align(
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: border != null ? Border.all(color: border.withValues(alpha: 0.7)) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final w in lines) ...[
              Container(height: 5, width: w, decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(3))),
              const SizedBox(height: 4),
            ],
          ],
        ),
      ),
    );
  }
}

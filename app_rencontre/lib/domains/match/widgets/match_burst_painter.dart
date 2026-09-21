import 'package:flutter/material.dart';

/// Two rings spreading from the middle of the avatar row at the moment the two
/// people meet. The second one follows the first with a short delay.
class MatchBurstPainter extends CustomPainter {
    /// 0 to 1 over the whole burst; nothing is drawn at either end.
    final double progress;

    MatchBurstPainter(this.progress);

    @override
    void paint(Canvas canvas, Size size) {
        final center = size.center(Offset.zero);
        for (var ring = 0; ring < 2; ring++) {
            final p = (progress - ring * 0.18) / 0.82;
            if (p <= 0 || p >= 1) continue;
            final paint = Paint()
                ..style       = PaintingStyle.stroke
                ..strokeWidth = 0.5 + 3 * (1 - p)
                ..color       = const Color(0xFFD400FF).withValues(alpha: 0.55 * (1 - p));
            canvas.drawCircle(center, 30 + 150 * Curves.easeOutCubic.transform(p), paint);
        }
    }

    @override
    bool shouldRepaint(MatchBurstPainter oldDelegate) => oldDelegate.progress != progress;
}

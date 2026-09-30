import 'package:flutter/material.dart';

/// A miniature swipe card stack, echoing the real discovery screen.
class DiscoverPreview extends StatelessWidget {
  const DiscoverPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // A second card peeking out behind, selling "a stack of profiles".
          Transform.translate(
            offset: const Offset(0, 10),
            child: Transform.scale(
              scale: 0.92,
              child: _card(const Color(0xFF2D0040), opacity: 0.6),
            ),
          ),
          Transform.translate(offset: const Offset(0, -8), child: _card(const Color(0xFF7B00D4))),
          Positioned(
            bottom: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionDot(Icons.close, const Color(0xFFEF4444)),
                const SizedBox(width: 14),
                _actionDot(Icons.favorite, const Color(0xFF7B00D4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(Color accent, {double opacity = 1}) => Opacity(
    opacity: opacity,
    child: Container(
      width: 108, height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [accent.withValues(alpha: 0.5), const Color(0xFF1A0030)],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.6)),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(width: 44, height: 6, decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85), borderRadius: BorderRadius.circular(3))),
        ),
      ),
    ),
  );

  Widget _actionDot(IconData icon, Color color) => Container(
    width: 30, height: 30,
    decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF1A0A1F), border: Border.all(color: color)),
    child: Icon(icon, size: 15, color: color),
  );
}

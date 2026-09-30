import 'package:flutter/material.dart';

/// A miniature swipe-card shape, reused for both the static back card and
/// the animated front card in [SwipeDemo].
class SwipeDemoCard extends StatelessWidget {
  final Color accent;
  final double opacity;
  const SwipeDemoCard({super.key, required this.accent, this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    return Opacity(
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
            child: Container(
              width: 44, height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

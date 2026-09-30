import 'package:flutter/material.dart';

/// One of the two small like/pass buttons under [SwipeDemo]'s cards, glowing
/// while its action is playing out.
class SwipeDemoActionDot extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool active;
  const SwipeDemoActionDot({super.key, required this.icon, required this.color, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 30, height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? color.withValues(alpha: 0.25) : const Color(0xFF1A0A1F),
        border: Border.all(color: color),
      ),
      child: Icon(icon, size: 15, color: color),
    );
  }
}

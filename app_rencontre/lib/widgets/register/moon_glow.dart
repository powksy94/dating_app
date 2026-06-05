import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MoonGlow extends StatelessWidget {
  final AnimationController glowCtrl;
  const MoonGlow({super.key, required this.glowCtrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowCtrl,
      builder: (_, child) => Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7B00D4).withValues(
                alpha: 0.3 + glowCtrl.value * 0.35,
              ),
              blurRadius: 40 + glowCtrl.value * 30,
              spreadRadius: 4 + glowCtrl.value * 8,
            ),
            BoxShadow(
              color: const Color(0xFFB040FF).withValues(
                alpha: 0.1 + glowCtrl.value * 0.15,
              ),
              blurRadius: 80 + glowCtrl.value * 40,
              spreadRadius: 0,
            ),
          ],
        ),
        child: child,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/icons/app_icon.png',
          width: 140,
          height: 140,
          fit: BoxFit.cover,
        ),
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.0, 0.0),
          end: const Offset(1.0, 1.0),
          duration: 800.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 500.ms);
  }
}

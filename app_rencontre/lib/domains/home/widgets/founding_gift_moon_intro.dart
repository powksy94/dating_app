import 'package:flutter/material.dart';
import 'package:nocturne/shared/widgets/common/realistic_moon.dart';

/// The opening beat of the reveal: a moon hanging in the sky, pulsing gently,
/// before the view drops down to the letter waiting below it.
class FoundingGiftMoonIntro extends StatelessWidget {
  final AnimationController glowCtrl;
  const FoundingGiftMoonIntro({super.key, required this.glowCtrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowCtrl,
      builder: (context, _) => RealisticMoon(size: 150, glow: glowCtrl.value),
    );
  }
}

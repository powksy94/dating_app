import 'package:flutter/material.dart';

class OnboardingTourDots extends StatelessWidget {
  final int count;
  final int activeIndex;
  const OnboardingTourDots({super.key, required this.count, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF7B00D4) : const Color(0xFF3D2A4A),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

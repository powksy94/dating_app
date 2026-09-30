import 'package:flutter/material.dart';
import 'package:nocturne/domains/onboarding/models/onboarding_tour_step.dart';
import 'package:nocturne/domains/onboarding/widgets/feature_bubble.dart';

class OnboardingTourSlide extends StatelessWidget {
  final OnboardingTourStep step;
  const OnboardingTourSlide({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FeatureBubble(color: step.color, child: step.preview),
          const SizedBox(height: 40),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            step.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 15, height: 1.4),
          ),
        ],
      ),
    );
  }
}

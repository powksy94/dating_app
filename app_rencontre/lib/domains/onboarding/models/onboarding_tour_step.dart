import 'package:flutter/material.dart';

/// One slide of the post-registration feature tour: an icon, its accent
/// color, and the title/subtitle explaining that part of the app.
class OnboardingTourStep {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const OnboardingTourStep({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });
}

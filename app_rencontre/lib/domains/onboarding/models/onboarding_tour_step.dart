import 'package:flutter/material.dart';

/// One slide of the post-registration feature tour: a small illustrated
/// preview of that part of the app, its accent color for the bubble's glow,
/// and the title/subtitle explaining it.
class OnboardingTourStep {
  final Widget preview;
  final Color color;
  final String title;
  final String subtitle;

  const OnboardingTourStep({
    required this.preview,
    required this.color,
    required this.title,
    required this.subtitle,
  });
}

import 'package:flutter/material.dart';

class SectionBlock extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionBlock({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF7B00D4),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0A1F),
            borderRadius: BorderRadius.circular(14),
          ),
          child: child,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF7B00D4),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}

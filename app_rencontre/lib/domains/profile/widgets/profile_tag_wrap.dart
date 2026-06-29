import 'package:flutter/material.dart';

class ProfileTagWrap extends StatelessWidget {
  final List<String> tags;
  final Color color;
  const ProfileTagWrap(this.tags, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: tags.map((tag) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 0.8),
        ),
        child: Text(tag,
            style: const TextStyle(
                color: Colors.white, fontSize: 12)),
      )).toList(),
    );
  }
}

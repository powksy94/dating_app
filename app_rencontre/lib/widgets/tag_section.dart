import 'package:flutter/material.dart';

class TagSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> tags;
  final List<String> selected;
  final void Function(bool, String) onToggle;

  const TagSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xFF7B00D4),
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2)),
        const SizedBox(height: 2),
        Text(subtitle,
            style: const TextStyle(
                color: Color(0xFFAA9AB5), fontSize: 11)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            final isSelected = selected.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (v) => onToggle(v, tag),
              selectedColor: const Color(0xFF7B00D4),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFAA9AB5),
                fontSize: 12,
              ),
              backgroundColor: const Color(0xFF1A0A1F),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFF7B00D4)
                    : const Color(0xFF3A2A4A),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

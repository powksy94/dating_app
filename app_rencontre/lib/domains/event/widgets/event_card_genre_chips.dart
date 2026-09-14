import 'package:flutter/material.dart';

class EventCardGenreChips extends StatelessWidget {
  final List<String> genres;
  const EventCardGenreChips({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: genres.take(3).map((g) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF2D0040),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(g,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 11)),
      )).toList(),
    );
  }
}

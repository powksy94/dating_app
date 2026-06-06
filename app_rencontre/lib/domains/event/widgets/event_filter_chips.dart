import 'package:flutter/material.dart';

enum EventFilter { all, attending, matches, favorites }

class EventFilterChips extends StatelessWidget {
  final EventFilter current;
  final void Function(EventFilter) onChanged;

  const EventFilterChips({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF120018),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _chip('Tous', EventFilter.all, Icons.public),
            const SizedBox(width: 8),
            _chip(
              'Inscrits',
              EventFilter.attending,
              Icons.check_circle_outline,
            ),
            const SizedBox(width: 8),
            _chip('Mes matchs', EventFilter.matches, Icons.people_outline),
            const SizedBox(width: 8),
            _chip('Favoris', EventFilter.favorites, Icons.favorite_border),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, EventFilter value, IconData icon) {
    final active = current == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF7B00D4) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? const Color(0xFF7B00D4) : const Color(0xFF3D2A4A),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: active ? Colors.white : const Color(0xFF5A4A6A),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFF5A4A6A),
                fontSize: 12,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

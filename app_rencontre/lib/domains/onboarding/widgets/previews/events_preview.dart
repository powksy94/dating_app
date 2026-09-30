import 'package:flutter/material.dart';

/// A miniature of the real event card (event_card.dart / event_card_cover.dart),
/// scaled down and centered so the whole thing stays inside the round bubble
/// it sits in (a ClipOval crops anything reaching the corners of its box).
class EventsPreview extends StatelessWidget {
  const EventsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      child: Center(
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _cover(),
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerLeft, child: _chip('DARK WAVE')),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(height: 8, width: 90, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3))),
              ),
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 10, color: Color(0xFF5A4A6A)),
                const SizedBox(width: 4),
                Container(height: 6, width: 30, color: const Color(0xFF5A4A6A)),
                const SizedBox(width: 8),
                const Icon(Icons.location_on_outlined, size: 10, color: Color(0xFF5A4A6A)),
                const SizedBox(width: 4),
                Container(height: 6, width: 36, color: const Color(0xFF5A4A6A)),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cover() => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: SizedBox(
      height: 60,
      child: Stack(
        children: [
          Container(
            width: double.infinity, height: 60,
            color: const Color(0xFF2D0040),
            child: const Center(child: Icon(Icons.music_note, size: 22, color: Color(0xFF7B00D4))),
          ),
          Positioned(
            top: 6, right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF1A5C1A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2ECC71)),
              ),
              child: const Text('FREE', style: TextStyle(color: Color(0xFF2ECC71), fontSize: 7, fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            top: 6, left: 6,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
              child: const Icon(Icons.favorite, size: 9, color: Color(0xFFD400FF)),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _chip(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0xFF4A0072).withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFF4A0072), width: 0.8),
    ),
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w600)),
  );
}

import 'package:flutter/material.dart';

/// A miniature of the real event card (event_card.dart / event_card_cover.dart):
/// same colors, same cover-with-badges-over-a-photo layout, same chip/title/
/// meta-row/attend-button structure, just scaled down to fit the bubble.
class EventsPreview extends StatelessWidget {
  const EventsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      padding: const EdgeInsets.all(18),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF3D2A4A)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cover(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _chip('DARK WAVE'),
                  const SizedBox(height: 5),
                  Container(height: 7, width: 70, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3))),
                  const SizedBox(height: 5),
                  Row(children: [
                    const Icon(Icons.calendar_today_outlined, size: 9, color: Color(0xFF5A4A6A)),
                    const SizedBox(width: 3),
                    Container(height: 5, width: 24, color: const Color(0xFF5A4A6A)),
                    const SizedBox(width: 6),
                    const Icon(Icons.location_on_outlined, size: 9, color: Color(0xFF5A4A6A)),
                    const SizedBox(width: 3),
                    Container(height: 5, width: 30, color: const Color(0xFF5A4A6A)),
                  ]),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.people_outline, size: 11, color: Color(0xFF5A4A6A)),
                        const SizedBox(width: 3),
                        Container(height: 5, width: 18, color: const Color(0xFF5A4A6A)),
                      ]),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFF7B00D4), borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.check, size: 9, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cover() => SizedBox(
    height: 58,
    child: Stack(
      children: [
        Container(
          width: double.infinity, height: 58,
          color: const Color(0xFF2D0040),
          child: const Center(child: Icon(Icons.music_note, size: 22, color: Color(0xFF7B00D4))),
        ),
        Positioned(
          top: 5, right: 5,
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
          top: 5, left: 5,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
            child: const Icon(Icons.favorite, size: 9, color: Color(0xFFD400FF)),
          ),
        ),
      ],
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

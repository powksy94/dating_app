import 'package:flutter/material.dart';

/// A miniature event card with a date badge, echoing the real events list.
class EventsPreview extends StatelessWidget {
  const EventsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      padding: const EdgeInsets.all(28),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFB667FF).withValues(alpha: 0.5)),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(color: const Color(0xFFB667FF), borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('OCT', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
                      Text('12', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, height: 1)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 7, decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(3))),
                      const SizedBox(height: 6),
                      Container(height: 5, width: 40, decoration: BoxDecoration(color: const Color(0xFF5A4A6A), borderRadius: BorderRadius.circular(3))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 20,
              child: Stack(
                children: List.generate(3, (i) => Positioned(
                  left: i * 12.0,
                  child: Container(
                    width: 18, height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.lerp(const Color(0xFF7B00D4), const Color(0xFFB667FF), i / 2),
                      border: Border.all(color: const Color(0xFF1A0A1F), width: 1.5),
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

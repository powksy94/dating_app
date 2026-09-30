import 'package:flutter/material.dart';

/// A miniature of the real ProfileCard (profile_card.dart): photo, bottom-up
/// dark gradient, username/age, and the colored aesthetic chips — kept as a
/// small centered card (not full-bleed) so nothing reaches the corners the
/// round bubble's ClipOval would crop.
class ProfilePreview extends StatelessWidget {
  const ProfilePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            width: 130, height: 158,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(-0.2, -0.3),
                      radius: 1.1,
                      colors: [Color(0xFF3D0066), Color(0xFF1A0A1F)],
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter, end: Alignment.topCenter,
                      colors: [const Color(0xFF0D0009).withValues(alpha: 0.92), Colors.transparent],
                      stops: const [0.0, 0.65],
                    ),
                  ),
                ),
                Positioned(
                  left: 10, right: 10, bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('Ophelia', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Text('26', style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _chip('GOTH', const Color(0xFF4A0072)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color, width: 0.8),
    ),
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w600)),
  );
}

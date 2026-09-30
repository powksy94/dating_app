import 'package:flutter/material.dart';

/// A miniature of the real ProfileCard (profile_card.dart): full-bleed
/// photo, bottom-up dark gradient, username/age/pronouns baseline row, and
/// the colored aesthetic chips — same recipe used for both the swipe card
/// and "My profile", just scaled down.
class ProfilePreview extends StatelessWidget {
  const ProfilePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
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
            top: 14, right: 14,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
              child: const Icon(Icons.edit, size: 11, color: Colors.white70),
            ),
          ),
          Positioned(
            left: 18, right: 18, bottom: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('Ophelia', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    Text('26', style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4, runSpacing: 4,
                  children: [
                    _chip('GOTH', const Color(0xFF4A0072)),
                    _chip('DARK WAVE', const Color(0xFF003366)),
                  ],
                ),
              ],
            ),
          ),
        ],
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
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 6.5, fontWeight: FontWeight.w600)),
  );
}

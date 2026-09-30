import 'package:flutter/material.dart';

/// A miniature profile card with an avatar and tag pills, echoing the real
/// profile screen.
class ProfilePreview extends StatelessWidget {
  const ProfilePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0010),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72, height: 72,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [Color(0xFF9D2FE8), Color(0xFF3D0066)]),
            ),
            child: const Icon(Icons.person, color: Colors.white70, size: 36),
          ),
          const SizedBox(height: 12),
          Container(height: 8, width: 70, decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6, runSpacing: 6,
            children: ['', '', ''].asMap().entries.map((e) => Container(
              width: 30 + e.key * 8.0, height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF5A2E8C).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: const Color(0xFF5A2E8C)),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

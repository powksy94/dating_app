import 'package:flutter/material.dart';
import '../../models/alternative_profile.dart';
import '../profile/profile_card.dart';

/// Carte de swipe avec overlays like/nope selon le déplacement horizontal.
/// [horizontalOffset] : pourcentage fourni par CardSwiper (positif = droite, négatif = gauche)
class SwipeCard extends StatelessWidget {
  final AlternativeProfile profile;
  final double horizontalOffset;
  final VoidCallback onTap;

  const SwipeCard({
    super.key,
    required this.profile,
    required this.horizontalOffset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ProfileCard(profile: profile),

          if (horizontalOffset > 0)
            _SwipeOverlay(
              icon: Icons.favorite,
              color: const Color(0xFF00C853),
              label: 'LIKE',
              opacity: (horizontalOffset / 60).clamp(0.0, 1.0),
              alignment: Alignment.topLeft,
            ),

          if (horizontalOffset < 0)
            _SwipeOverlay(
              icon: Icons.close,
              color: const Color(0xFF8B0000),
              label: 'NOPE',
              opacity: (-horizontalOffset / 60).clamp(0.0, 1.0),
              alignment: Alignment.topRight,
            ),
        ],
      ),
    );
  }
}

class _SwipeOverlay extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final double opacity;
  final Alignment alignment;

  const _SwipeOverlay({
    required this.icon,
    required this.color,
    required this.label,
    required this.opacity,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Opacity(
              opacity: opacity,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: color, size: 36),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        color: color,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

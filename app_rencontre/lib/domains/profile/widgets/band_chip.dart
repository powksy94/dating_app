import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A favorite band pastille. In delete mode it wiggles and shows a small minus
/// badge at its top right corner, which removes it.
class BandChip extends StatelessWidget {
  final String label;
  final bool deleteMode;
  final int index;
  final VoidCallback onDelete;

  const BandChip({
    super.key,
    required this.label,
    required this.deleteMode,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // The top and right margin is always there, so the badge stays inside the
    // tappable bounds and the layout does not move when the mode changes.
    final pastille = Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Chip(
            label: Text(label, style: const TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF2A1A35),
          ),
        ),
        if (deleteMode)
          Positioned(top: 0, right: 0, child: _MinusBadge(onTap: onDelete)),
      ],
    );
    if (!deleteMode) return pastille;

    // Each pastille starts at a slightly different moment, so they do not
    // all move in unison.
    return pastille
        .animate(
          delay: (index * 40).ms,
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .rotate(
          begin: -0.006,
          end: 0.006,
          duration: 130.ms,
          curve: Curves.easeInOut,
        );
  }
}

class _MinusBadge extends StatelessWidget {
  final VoidCallback onTap;
  const _MinusBadge({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: Color(0xFFC62828),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.remove, size: 15, color: Colors.white),
      ),
    );
  }
}

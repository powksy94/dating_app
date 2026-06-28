import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class SwipeCounterBar extends StatelessWidget {
  final int remaining;
  final int limit;
  const SwipeCounterBar({super.key, required this.remaining, required this.limit});

  @override
  Widget build(BuildContext context) {
    final ratio = limit > 0 ? remaining / limit : 1.0;
    final color = ratio > 0.5
        ? const Color(0xFF7B00D4)
        : ratio > 0.2
            ? const Color(0xFFFFA500)
            : const Color(0xFF8B0000);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(Icons.swap_horiz, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            AppLocalizations.of(context)!.discoverySwipeCounter(remaining, limit),
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          SizedBox(
            width: 80,
            child: LinearProgressIndicator(
              value: ratio.clamp(0.0, 1.0),
              backgroundColor: const Color(0xFF2A1A35),
              color: color,
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

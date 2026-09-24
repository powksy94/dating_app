import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// The card that slides out of the envelope once its seal has broken:
/// announces the gift and lets the user dismiss the reveal.
class FoundingGiftRevealCard extends StatelessWidget {
  final AppLocalizations l;
  final VoidCallback onClose;
  const FoundingGiftRevealCard({super.key, required this.l, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0030),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF7B00D4), width: 1),
        boxShadow: const [BoxShadow(color: Color(0x557B00D4), blurRadius: 30, spreadRadius: 4)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l.giftRevealTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2,
              shadows: [Shadow(color: Color(0xFF9B4DFF), blurRadius: 16)],
            ),
          ).animate().fadeIn(delay: 150.ms, duration: 500.ms).slideY(begin: 0.15, end: 0, curve: Curves.easeOutCubic),
          const SizedBox(height: 10),
          Text(
            l.giftRevealSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
          ).animate().fadeIn(delay: 350.ms, duration: 500.ms),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l.giftRevealClose),
            ),
          ).animate().fadeIn(delay: 550.ms, duration: 500.ms),
        ],
      ),
    );
  }
}

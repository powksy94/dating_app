import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_stage.dart';

/// The text under the envelope: a pulsing tap hint while sealed, or an
/// error message with a retry button if the claim call failed. Nothing is
/// shown while claiming or already opening/revealed.
class FoundingGiftCaption extends StatelessWidget {
  final GiftStage stage;
  final VoidCallback onRetry;
  final AppLocalizations l;
  const FoundingGiftCaption({super.key, required this.stage, required this.onRetry, required this.l});

  @override
  Widget build(BuildContext context) {
    if (stage == GiftStage.sealed) {
      return Text(l.giftRevealHint, style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13))
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeIn(duration: 900.ms)
          .then()
          .fadeOut(duration: 900.ms);
    }
    if (stage == GiftStage.error) {
      return Column(
        children: [
          Text(
            l.giftRevealErrorTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            l.giftRevealErrorSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B00D4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(l.giftRevealRetry),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

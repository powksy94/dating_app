import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_caption.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_seal_stack.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_stage.dart';

/// Composes the tappable seal stack with its caption underneath.
class FoundingGiftEnvelope extends StatelessWidget {
  final GiftStage stage;
  final AnimationController glowCtrl;
  final AnimationController crackCtrl;
  final AnimationController flapCtrl;
  final VoidCallback onTap;
  final VoidCallback onRetry;
  final AppLocalizations l;

  const FoundingGiftEnvelope({
    super.key,
    required this.stage,
    required this.glowCtrl,
    required this.crackCtrl,
    required this.flapCtrl,
    required this.onTap,
    required this.onRetry,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: kGiftEnvelopeWidth,
            height: kGiftEnvelopeHeight + 40,
            child: AnimatedBuilder(
              animation: Listenable.merge([glowCtrl, crackCtrl, flapCtrl]),
              builder: (context, _) => FoundingGiftSealStack(
                stage: stage, glowCtrl: glowCtrl, crackCtrl: crackCtrl, flapCtrl: flapCtrl,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        FoundingGiftCaption(stage: stage, onRetry: onRetry, l: l),
      ],
    );
  }
}

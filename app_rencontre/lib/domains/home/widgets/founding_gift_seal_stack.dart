import 'package:flutter/material.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_painters.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_stage.dart';

const kGiftEnvelopeWidth  = 260.0;
const kGiftEnvelopeHeight = 170.0;
const kGiftFlapHeight = 96.0;
const kGiftSealSize = 72.0;

/// Purely visual: the closed envelope body, its flap (rotating open once
/// [flapCtrl] advances), and the glowing wax seal (cracking as [crackCtrl]
/// advances, then fading away once [stage] moves past the crack).
class FoundingGiftSealStack extends StatelessWidget {
  final GiftStage stage;
  final AnimationController glowCtrl;
  final AnimationController crackCtrl;
  final AnimationController flapCtrl;

  const FoundingGiftSealStack({
    super.key, required this.stage, required this.glowCtrl, required this.crackCtrl, required this.flapCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final sealGone = stage == GiftStage.opening || stage == GiftStage.revealed;
    // While waiting on the claim call, the seal glows harder and faster
    // instead of showing a generic spinner that would clash with the wax.
    final claiming = stage == GiftStage.claiming;
    final glow = claiming ? 0.6 + glowCtrl.value * 0.4 : 0.35 + glowCtrl.value * 0.35;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Ambient drop shadow: without it the envelope reads as a flat
        // decal pasted on the stars instead of an object sitting in space.
        Positioned(
          top: 48,
          child: Container(
            width: kGiftEnvelopeWidth,
            height: kGiftEnvelopeHeight,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 28, spreadRadius: -6)],
            ),
          ),
        ),
        const Positioned(
          top: 40,
          child: CustomPaint(size: Size(kGiftEnvelopeWidth, kGiftEnvelopeHeight), painter: EnvelopeBodyPainter()),
        ),
        Positioned(
          top: 40,
          child: Transform(
            alignment: Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(-flapCtrl.value * 2.4),
            // Rounded to match the body's own corner radius: the flap's
            // bounding box is a plain rectangle, so without this its sharp
            // top corners poke out past the body's rounded ones.
            child: const ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              child: CustomPaint(size: Size(kGiftEnvelopeWidth, kGiftFlapHeight), painter: EnvelopeFlapPainter()),
            ),
          ),
        ),
        Positioned(
          top: 40 + kGiftFlapHeight - kGiftSealSize / 2,
          child: AnimatedOpacity(
            opacity: sealGone ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: AnimatedScale(
              scale: sealGone ? 1.3 : 1.0,
              duration: const Duration(milliseconds: 250),
              child: Container(
                width: kGiftSealSize,
                height: kGiftSealSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B4DFF).withValues(alpha: glow),
                      blurRadius: (claiming ? 30 : 24) + glowCtrl.value * 20,
                      spreadRadius: (claiming ? 4 : 2) + glowCtrl.value * 4,
                    ),
                  ],
                ),
                child: CustomPaint(painter: WaxSealPainter(crackProgress: crackCtrl.value)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

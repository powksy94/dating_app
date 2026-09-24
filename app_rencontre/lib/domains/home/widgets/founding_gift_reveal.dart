import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/star_field.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_card.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_envelope.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_stage.dart';

/// Full-screen founding-member gift reveal: a wax-sealed envelope the user
/// taps to open. [onClaim] is injected (real API call in production, a fake
/// always-true call from the debug preview) so this widget never talks to
/// the network itself.
class FoundingGiftReveal extends StatefulWidget {
  final Future<bool> Function() onClaim;
  const FoundingGiftReveal({super.key, required this.onClaim});

  @override
  State<FoundingGiftReveal> createState() => _FoundingGiftRevealState();
}

class _FoundingGiftRevealState extends State<FoundingGiftReveal> with TickerProviderStateMixin {
  GiftStage _stage = GiftStage.sealed;

  late final AnimationController _glowCtrl;
  late final AnimationController _crackCtrl;
  late final AnimationController _flapCtrl;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat(reverse: true);
    _crackCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _flapCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _crackCtrl.dispose();
    _flapCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_stage != GiftStage.sealed) return;
    HapticFeedback.mediumImpact();
    setState(() => _stage = GiftStage.claiming);

    final ok = await widget.onClaim();
    if (!mounted) return;
    if (!ok) {
      setState(() => _stage = GiftStage.error);
      return;
    }

    setState(() => _stage = GiftStage.opening);
    await _crackCtrl.forward();
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 200));
    await _flapCtrl.forward();
    if (!mounted) return;
    setState(() => _stage = GiftStage.revealed);
  }

  void _retry() {
    _crackCtrl.reset();
    _flapCtrl.reset();
    setState(() => _stage = GiftStage.sealed);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return PopScope(
      // The gift stays owed (still 'pending' server-side) until claimed:
      // never let a back-gesture dismiss it without a decision.
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF04000A),
        body: Stack(
          children: [
            const Positioned.fill(child: StarField()),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _stage == GiftStage.revealed
                    ? FoundingGiftRevealCard(key: const ValueKey('revealed'), l: l, onClose: () => Navigator.pop(context))
                    : FoundingGiftEnvelope(
                        key: const ValueKey('envelope'),
                        stage: _stage,
                        glowCtrl: _glowCtrl,
                        crackCtrl: _crackCtrl,
                        flapCtrl: _flapCtrl,
                        onTap: _handleTap,
                        onRetry: _retry,
                        l: l,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

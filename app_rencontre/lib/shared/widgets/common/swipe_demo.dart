import 'package:flutter/material.dart';
import 'package:nocturne/shared/widgets/common/swipe_demo_card.dart';
import 'package:nocturne/shared/widgets/common/swipe_demo_action_dot.dart';

/// A looping, purely illustrative swipe demo: the front card flies off
/// (right for a like, left for a pass) with a corner stamp, then the cycle
/// repeats. Never touches a real profile or the backend — reusable anywhere
/// the app wants to show "this is how swiping works" (onboarding, an empty
/// state, ...).
class SwipeDemo extends StatefulWidget {
  const SwipeDemo({super.key});

  @override
  State<SwipeDemo> createState() => _SwipeDemoState();
}

class _SwipeDemoState extends State<SwipeDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  bool _liking = true;
  bool _stopped = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
    _loop();
  }

  Future<void> _loop() async {
    while (!_stopped) {
      await Future.delayed(const Duration(milliseconds: 650));
      if (_stopped) return;
      await _ctrl.forward(from: 0);
      if (_stopped) return;
      // Reset the controller (t=0 keeps both buttons dark no matter what
      // _liking is) before flipping _liking, not after: otherwise there's a
      // frame where _liking has already flipped but t is still 1, lighting
      // up the wrong button for an instant (looked like a stray second tap).
      _ctrl.value = 0;
      setState(() => _liking = !_liking);
    }
  }

  @override
  void dispose() {
    _stopped = true;
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        // Eased, non-overshooting: safe to feed Opacity directly. The card's
        // own fade runs faster than its travel (cardOpacity hits 0 around
        // t=0.6) so it's fully gone well before it would reach the bubble's
        // circular clip edge — otherwise the card's corners (e.g. the little
        // bottom-left bar) get clipped at a different moment than its body,
        // leaving a stray fragment visible on its own for a frame or two.
        final t = Curves.easeInCubic.transform(_ctrl.value);
        final dx = (_liking ? 1 : -1) * t * 150;
        final rotation = (_liking ? 1 : -1) * t * 0.4;
        final cardOpacity = 1 - (t * 1.7).clamp(0.0, 1.0);
        final stampOpacity = (t * 2.2).clamp(0.0, 1.0);
        // The back card only fades in once the front one is essentially
        // gone (past t=0.6): otherwise both are translucent at once and
        // briefly look like two ghostly overlapping cards.
        final backOpacity = ((t - 0.6) / 0.4).clamp(0.0, 1.0) * 0.6;

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(scale: 0.9, child: SwipeDemoCard(accent: const Color(0xFF2D0040), opacity: backOpacity)),
            Transform.translate(
              offset: Offset(dx, 0),
              child: Transform.rotate(
                angle: rotation,
                child: Opacity(
                  opacity: cardOpacity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const SwipeDemoCard(accent: Color(0xFF7B00D4)),
                      Positioned(
                        top: 14,
                        left: _liking ? null : 10,
                        right: _liking ? 10 : null,
                        child: Opacity(
                          opacity: stampOpacity,
                          child: Transform.rotate(
                            angle: _liking ? -0.3 : 0.3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                border: Border.all(color: _liking ? const Color(0xFF7B00D4) : const Color(0xFFEF4444), width: 2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _liking ? 'LIKE' : 'PASS',
                                style: TextStyle(
                                  color: _liking ? const Color(0xFF7B00D4) : const Color(0xFFEF4444),
                                  fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // A single short pulse right as the swipe starts (like a
                  // tap being acknowledged), not held lit for the whole
                  // swipe — otherwise its fade-in and fade-out read as two
                  // separate flashes bracketing the animation.
                  SwipeDemoActionDot(icon: Icons.close, color: const Color(0xFFEF4444), active: !_liking && t > 0.05 && t < 0.35),
                  const SizedBox(width: 14),
                  SwipeDemoActionDot(icon: Icons.favorite, color: const Color(0xFF7B00D4), active: _liking && t > 0.05 && t < 0.35),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

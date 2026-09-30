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
      setState(() => _liking = !_liking);
      _ctrl.value = 0;
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
        // Eased, non-overshooting: safe to feed the card's Opacity directly.
        final t = Curves.easeInCubic.transform(_ctrl.value);
        final dx = (_liking ? 1 : -1) * t * 150;
        final rotation = (_liking ? 1 : -1) * t * 0.4;
        final stampOpacity = (t * 2.2).clamp(0.0, 1.0);

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(scale: 0.9, child: const SwipeDemoCard(accent: Color(0xFF2D0040), opacity: 0.6)),
            Transform.translate(
              offset: Offset(dx, 0),
              child: Transform.rotate(
                angle: rotation,
                child: Opacity(
                  opacity: 1 - t,
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
                  SwipeDemoActionDot(icon: Icons.close, color: const Color(0xFFEF4444), active: !_liking && t > 0.05),
                  const SizedBox(width: 14),
                  SwipeDemoActionDot(icon: Icons.favorite, color: const Color(0xFF7B00D4), active: _liking && t > 0.05),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

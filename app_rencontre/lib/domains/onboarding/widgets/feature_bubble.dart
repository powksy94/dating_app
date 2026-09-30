import 'package:flutter/material.dart';

/// The round frame a feature preview sits in, with a soft glow and a
/// zoom-in entrance so each slide feels like it's revealing something
/// rather than just labeling it.
class FeatureBubble extends StatefulWidget {
  final Widget child;
  final Color color;
  const FeatureBubble({super.key, required this.child, required this.color});

  @override
  State<FeatureBubble> createState() => _FeatureBubbleState();
}

class _FeatureBubbleState extends State<FeatureBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    // The zoom is allowed to overshoot a touch (Curves.easeOutBack) since it
    // only drives Transform.scale; the fade stays on a non-overshooting
    // curve, since that one feeds Opacity directly.
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => Opacity(
        opacity: _fade.value,
        child: Transform.scale(scale: 0.6 + _scale.value * 0.4, child: child),
      ),
      child: Container(
        width: 250, height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF120018),
          boxShadow: [
            BoxShadow(color: widget.color.withValues(alpha: 0.35), blurRadius: 50, spreadRadius: 6),
          ],
          border: Border.all(color: widget.color.withValues(alpha: 0.4), width: 1.4),
        ),
        child: ClipOval(child: widget.child),
      ),
    );
  }
}

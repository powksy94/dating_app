import 'package:flutter/material.dart';

const _kMoonBright = Color(0xFFEDE8F5);
const _kMoonMid    = Color(0xFFA79DC2);
const _kMoonShadow = Color(0xFF5C5476);

/// A pale, cratered moon with a soft violet ambient glow behind it. [glow]
/// (0 to 1) drives how strong that glow is, so callers can pulse it with
/// their own AnimationController.
class RealisticMoon extends StatelessWidget {
  final double size;
  final double glow;
  const RealisticMoon({super.key, required this.size, this.glow = 0.5});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B4DFF).withValues(alpha: 0.25 + glow * 0.25),
            blurRadius: size * (0.4 + glow * 0.25),
            spreadRadius: size * 0.05,
          ),
        ],
      ),
      child: const CustomPaint(painter: _RealisticMoonPainter()),
    );
  }
}

/// Fixed maria (the large dark "seas") and crater positions, spread across
/// the whole face like the real moon: always the same "face", never a
/// cluster in one corner.
class _RealisticMoonPainter extends CustomPainter {
  const _RealisticMoonPainter();

  // Each maria is a handful of overlapping circles, blurred together into
  // one soft irregular patch.
  static const _maria = [
    [(Offset(0.28, -0.38), 0.30), (Offset(0.45, -0.20), 0.22), (Offset(0.30, -0.15), 0.20)],
    [(Offset(-0.40, 0.05), 0.26), (Offset(-0.22, 0.15), 0.22), (Offset(-0.38, 0.28), 0.18)],
    [(Offset(0.15, 0.42), 0.24), (Offset(0.32, 0.38), 0.16)],
  ];

  static const _craters = [
    (Offset(-0.42, -0.35), 0.09),
    (Offset(-0.05, -0.55), 0.06),
    (Offset(0.20, 0.10), 0.05),
    (Offset(-0.15, -0.10), 0.04),
    (Offset(0.45, 0.15), 0.07),
    (Offset(0.02, 0.62), 0.08),
    (Offset(-0.50, 0.45), 0.06),
    (Offset(0.50, -0.45), 0.05),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, Paint()
      ..shader = const RadialGradient(
        center: Alignment(-0.35, -0.35),
        colors: [_kMoonBright, _kMoonMid, _kMoonShadow],
        stops: [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius)));

    canvas.saveLayer(Rect.fromCircle(center: center, radius: radius), Paint());
    final mariaPaint = Paint()
      ..color = _kMoonShadow.withValues(alpha: 0.4)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.08);
    for (final patch in _maria) {
      for (final (offset, relRadius) in patch) {
        canvas.drawCircle(center + offset * radius, relRadius * radius, mariaPaint);
      }
    }
    canvas.restore();

    // Each crater is a dark disc with a thin bright rim on its lit side, so
    // it stays visible whether it lands on the bright or the shadowed half.
    for (final (offset, relRadius) in _craters) {
      final c = center + offset * radius;
      final r = relRadius * radius;
      canvas.drawCircle(c, r, Paint()..color = const Color(0xFF453D5C).withValues(alpha: 0.55));
      canvas.drawCircle(c - Offset(r * 0.25, r * 0.25), r * 0.85, Paint()
        ..color = _kMoonBright.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.3);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

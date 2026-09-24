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

/// Fixed crater positions: always the same "face", like the real moon.
class _RealisticMoonPainter extends CustomPainter {
  const _RealisticMoonPainter();

  static const _craters = [
    (Offset(-0.32, -0.18), 0.16),
    (Offset(0.12, -0.35), 0.10),
    (Offset(0.30, 0.05), 0.14),
    (Offset(-0.08, 0.30), 0.12),
    (Offset(0.05, 0.12), 0.07),
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

    for (final (offset, relRadius) in _craters) {
      canvas.drawCircle(
        center + Offset(offset.dx * radius, offset.dy * radius),
        relRadius * radius,
        Paint()..color = _kMoonShadow.withValues(alpha: 0.35),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

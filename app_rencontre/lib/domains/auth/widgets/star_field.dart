import 'dart:math';
import 'package:flutter/material.dart';

class StarField extends StatefulWidget {
  const StarField({super.key});

  @override
  State<StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  static final _rng = Random(42);
  static final _stars = List.generate(32, (i) => _Star(
    x:        _rng.nextDouble(),
    y:        _rng.nextDouble(),
    size:     _rng.nextDouble() * 2.0 + 1.5,
    phase:    _rng.nextDouble() * 2 * pi,
    speed:    0.5 + _rng.nextDouble() * 1.5,
  ));

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _StarPainter(_stars, _ctrl.value),
        ),
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  final List<_Star> stars;
  final double t;
  const _StarPainter(this.stars, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    for (final s in stars) {
      final opacity = (sin(s.phase + t * s.speed * 2 * pi) * 0.5 + 0.5)
          .clamp(0.1, 1.0);
      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(
        Offset(s.x * size.width, s.y * size.height),
        s.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarPainter old) => old.t != t;
}

class _Star {
  final double x, y, size, phase, speed;
  const _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.phase,
    required this.speed,
  });
}

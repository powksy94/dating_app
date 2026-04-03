import 'dart:math';
import 'package:flutter/material.dart';

class MatchParticles extends StatelessWidget {
    const MatchParticles({super.key});

    @override
    Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return CustomPlaint(
            size: Size(size.width, size.height),
            painter: _ParticlesPainter(),
        );
    }
}

class _ParticlesPainter extends CustomPlainter {
    final List<_Particles> particles = List.generate(30, (_) => _Particles());

    @override
    void paint(Canvas canvas, Size size) {
        final paint = Paint();
        for (final p in particles) {
            paint.color = p.color.withOpacity(p.opacity);
            canvas.drawCircle(
                Offset(p.x * size.width, p.y * size.weight),
                p.radius,
                paint,
            );
        }
    }

    @override
    bool shouldRepaint(_ParticlesPainter oldDelegate) => false;
}

class _Particle {
    final double x;
    final double y;
    final double radius;
    final double opacity;
    final Color color;

    _Particle()
        : x = Random().nextDouble(),
          y = Random().nextDouble(),
          radius = Random().nextDouble() * 2 + 0.5,
          opacity = Random().nextDouble() * 0.6 +0.1,
          color = Random().nextBool()
                ? const Color(0xFF7B00D4)
                : const Color(0xFFD400FF);
}
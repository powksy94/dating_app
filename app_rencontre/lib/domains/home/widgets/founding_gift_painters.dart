import 'dart:math' as math;
import 'package:flutter/material.dart';

const _kSealColor  = Color(0xFF7B00D4);
const _kSealDark   = Color(0xFF4A0080);
const _kInkColor   = Color(0xFF1A0030);
const _kInkBorder  = Color(0xFF7B00D4);

/// The envelope's flat back: a dark rounded rectangle with a subtle
/// diagonal fold line on each side, so it still reads as an envelope
/// once the flap has rotated away from it.
class EnvelopeBodyPainter extends CustomPainter {
  const EnvelopeBodyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14));
    final fill = Paint()..color = _kInkColor;
    final border = Paint()
      ..color = _kInkBorder.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(rect, fill);
    canvas.drawRRect(rect, border);

    final fold = Paint()
      ..color = _kInkBorder.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = Offset(size.width / 2, size.height * 0.4);
    canvas.drawLine(Offset(0, size.height), center, fold);
    canvas.drawLine(Offset(size.width, size.height), center, fold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// The triangular flap, drawn as its own layer so it can be rotated open
/// around its top edge independently of the envelope body underneath.
class EnvelopeFlapPainter extends CustomPainter {
  const EnvelopeFlapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final apex = Offset(size.width / 2, size.height);
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(apex.dx, apex.dy)
      ..close();

    final fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_kInkColor, Color.lerp(_kInkColor, _kSealDark, 0.35)!],
      ).createShader(Offset.zero & size);
    final border = Paint()
      ..color = _kInkBorder.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawPath(path, fill);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A wax disc with a crescent moon carved out of it (two overlapping
/// circles combined with [PathOperation.difference]), plus jagged crack
/// lines that grow outward from the center as [crackProgress] goes 0 to 1.
class WaxSealPainter extends CustomPainter {
  final double crackProgress;
  const WaxSealPainter({required this.crackProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final sealPath = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.drawPath(
      sealPath,
      Paint()
        ..shader = const RadialGradient(
          colors: [_kSealColor, _kSealDark],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );

    final moonCutout = Path()
      ..addOval(Rect.fromCircle(center: center.translate(radius * 0.3, 0), radius: radius * 0.62));
    final crescent = Path.combine(PathOperation.difference, sealPath, moonCutout);
    canvas.drawPath(crescent, Paint()..color = _kSealDark.withValues(alpha: 0.8));

    if (crackProgress <= 0) return;
    final crackPaint = Paint()
      ..color = _kInkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    // Five cracks radiating at fixed angles: each is drawn as a short jagged
    // line, only up to `crackProgress` of its own length via extractPath.
    for (var i = 0; i < 5; i++) {
      final angle = (i / 5) * 2 * math.pi + 0.3;
      final full = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(
          center.dx + math.cos(angle) * radius * 0.5,
          center.dy + math.sin(angle) * radius * 0.5,
        )
        ..lineTo(
          center.dx + math.cos(angle + 0.4) * radius * 0.95,
          center.dy + math.sin(angle + 0.4) * radius * 0.95,
        );
      final metric = full.computeMetrics().first;
      canvas.drawPath(metric.extractPath(0, metric.length * crackProgress), crackPaint);
    }
  }

  @override
  bool shouldRepaint(covariant WaxSealPainter oldDelegate) => oldDelegate.crackProgress != crackProgress;
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

const _kSealBright = Color(0xFFB667FF);
const _kSealColor  = Color(0xFF8A1FE0);
const _kSealDark   = Color(0xFF3D0066);
const _kInkColor   = Color(0xFF150022);
const _kInkBorder  = Color(0xFF9B4DFF);
const _kBodyTop    = Color(0xFF1F0038);
const _kBodyBottom = Color(0xFF120020);
const _kFlapTop    = Color(0xFF3A0066);
const _kFlapBottom = Color(0xFF1A0030);

/// The envelope's flat back: a two-tone rounded rectangle (lighter at the
/// top, near the flap, darker toward the bottom) with a clearly visible
/// V-fold seam, so it still reads as an envelope once the flap has rotated
/// away from it.
class EnvelopeBodyPainter extends CustomPainter {
  const EnvelopeBodyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(14));
    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_kBodyTop, _kBodyBottom],
      ).createShader(Offset.zero & size);
    canvas.drawRRect(rect, fill);
    canvas.drawRRect(rect, Paint()
      ..color = _kInkBorder.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4);

    final fold = Paint()
      ..color = _kInkBorder.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final apex = Offset(size.width / 2, size.height * 0.42);
    canvas.drawLine(Offset(0, size.height), apex, fold);
    canvas.drawLine(Offset(size.width, size.height), apex, fold);

    // A short shadow just under where the flap's edge sits, so the flap
    // reads as sitting on top of the body rather than merging into it.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, 6),
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// The triangular flap, drawn as its own layer so it can be rotated open
/// around its top edge independently of the envelope body underneath. Its
/// gradient runs the opposite way from the body's, so the two clearly read
/// as separate pieces even at rest.
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

    canvas.drawPath(path, Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_kFlapTop, _kFlapBottom],
      ).createShader(Offset.zero & size));
    canvas.drawPath(path, Paint()
      ..color = _kInkBorder.withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4);

    // Center crease, from the top edge down to the apex, sells the fold.
    canvas.drawLine(
      Offset(size.width / 2, 0),
      apex,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A wax disc with a hand-dripped (slightly irregular) edge, a crescent moon
/// engraved into it, and jagged crack lines that grow outward from the
/// center as [crackProgress] goes 0 to 1.
class WaxSealPainter extends CustomPainter {
  final double crackProgress;
  const WaxSealPainter({required this.crackProgress});

  Path _driedEdgeCircle(Offset center, double radius) {
    const points = 28;
    final path = Path();
    for (var i = 0; i <= points; i++) {
      final angle = (i / points) * 2 * math.pi;
      final wobble = math.sin(angle * 5) * radius * 0.035 + math.sin(angle * 3 + 1.1) * radius * 0.025;
      final r = radius + wobble;
      final p = Offset(center.dx + math.cos(angle) * r, center.dy + math.sin(angle) * r);
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 2;

    final sealPath = _driedEdgeCircle(center, radius);
    canvas.drawPath(
      sealPath,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.3, -0.3),
          colors: [_kSealBright, _kSealColor, _kSealDark],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
    canvas.drawPath(sealPath, Paint()
      ..color = _kSealDark.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2);

    // Crescent moon, engraved: a dark crescent shadow plus a thin bright
    // highlight along its outer rim, so it reads on top of the gradient
    // regardless of how bright that spot of the wax is.
    final moonOuter = Path()..addOval(Rect.fromCircle(center: center.translate(-radius * 0.28, -radius * 0.05), radius: radius * 0.68));
    final moonInner = Path()..addOval(Rect.fromCircle(center: center.translate(-radius * 0.05, -radius * 0.05), radius: radius * 0.58));
    final crescent = Path.combine(PathOperation.difference, moonOuter, moonInner);
    canvas.drawPath(crescent, Paint()..color = Colors.black.withValues(alpha: 0.45));
    canvas.drawPath(crescent, Paint()
      ..color = _kSealBright.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1);

    if (crackProgress <= 0) return;
    final crackPaint = Paint()
      ..color = _kInkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
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

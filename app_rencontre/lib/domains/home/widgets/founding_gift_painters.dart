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
/// top, near the flap, darker toward the bottom). No fold lines of its own:
/// the flap's own triangle outline, drawn on top, is the only "V" shape, so
/// the two don't combine into a busy double cross.
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

    // The flap fully covers this V while closed, but as it lifts open it
    // reveals this soft crease shadow underneath, like paper that's been
    // folded there for a while: real depth, not just a stack of flat shapes.
    // 96 matches kGiftFlapHeight (founding_gift_seal_stack.dart); the blur
    // makes exact pixel alignment unnecessary.
    final crease = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, 96)
      ..close();
    canvas.drawPath(crease, Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10));

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

    // Center crease, kept short near the apex only: the seal sits right on
    // top of the upper part of the flap, so a full-length line would poke
    // out above it as a stray thread.
    canvas.drawLine(
      Offset(size.width / 2, size.height * 0.62),
      apex,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3)
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A wax disc styled like a real stamped seal: a scalloped outer ring lit
/// from the top-left, a smooth recessed inner disc, a glowing crescent moon
/// where a monogram would normally sit, and jagged crack lines that grow
/// outward from the center as [crackProgress] goes 0 to 1.
class WaxSealPainter extends CustomPainter {
  final double crackProgress;
  const WaxSealPainter({required this.crackProgress});

  /// A ring of small, even scallops (a real dripped-wax edge is bumpy all
  /// around, not lopsided), built from a single fixed-frequency wave so no
  /// one bump dominates and turns the disc into a "bean".
  Path _scallopedRing(Offset center, double radius) {
    const bumps = 16;
    final path = Path();
    for (var i = 0; i <= bumps * 3; i++) {
      final angle = (i / (bumps * 3)) * 2 * math.pi;
      final r = radius + math.sin(angle * bumps) * radius * 0.03;
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

    // Light comes from the top-left throughout the seal, like the reference
    // photo: every gradient below shares this axis for a consistent relief.
    final outerRing = _scallopedRing(center, radius);
    canvas.drawPath(
      outerRing,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment(-0.7, -0.7), end: Alignment(0.7, 0.7),
          colors: [_kSealBright, _kSealColor, _kSealDark],
          stops: [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
    canvas.drawPath(outerRing, Paint()
      ..color = _kSealDark.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2);

    // Inner disc: smooth (not scalloped), slightly smaller, its own subtler
    // version of the same top-left light so it reads as a recessed platform.
    final innerRadius = radius * 0.72;
    canvas.drawCircle(center, innerRadius, Paint()
      ..shader = LinearGradient(
        begin: const Alignment(-0.7, -0.7), end: const Alignment(0.7, 0.7),
        colors: [_kSealColor, Color.lerp(_kSealDark, Colors.black, 0.25)!],
      ).createShader(Rect.fromCircle(center: center, radius: innerRadius)));
    canvas.drawCircle(center, innerRadius, Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1);

    // Crescent moon, glowing like real moonlight rather than plain engraved
    // wax: a soft blurred halo behind a bright crescent, with a thin dark
    // seat line so it still reads as sitting in the wax, not floating on it.
    // The outer circle stays exactly on the seal's own center, so the
    // crescent's convex edge is centered; only the "bite" that carves the
    // crescent is offset sideways, the usual way to draw a moon icon.
    final moonRadius = radius * 0.4;
    final moonOuter = Path()..addOval(Rect.fromCircle(center: center, radius: moonRadius));
    final moonInner = Path()..addOval(Rect.fromCircle(center: center.translate(moonRadius * 0.55, 0), radius: moonRadius * 0.92));
    final crescent = Path.combine(PathOperation.difference, moonOuter, moonInner);

    canvas.drawPath(crescent, Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.12));
    canvas.drawPath(crescent, Paint()..color = const Color(0xFFF3E9FF));
    canvas.drawPath(crescent, Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8);

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

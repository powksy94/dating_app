import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

/// Dark violet veil behind the match screen. What is under it (the swipe card
/// with its name and bio) is blurred and not only dimmed, so its text no longer
/// shows through the overlay.
class MatchBackdrop extends StatelessWidget {
    /// 0 to 1: the veil and the blur grow together while the screen fades in.
    final double fade;

    const MatchBackdrop({super.key, required this.fade});

    @override
    Widget build(BuildContext context) {
        return Positioned.fill(
            child: ClipRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16 * fade, sigmaY: 16 * fade),
                    child: Opacity(
                        opacity: fade,
                        child: const DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                        Color(0xF20D0010),
                                        Color(0xF21A0030),
                                        Color(0xF20D0010),
                                    ],
                                ),
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}

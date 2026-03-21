import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedStep extends StatelessWidget {
    final Widget child;

    const AnimatedStep({super.key, required this.child});

    @override
    Widget build(BuildContext context) {
        return child
            .animate()
            .fadeIn(duration: 400.ms, curve: Curves.easeOut)
            .slideY(begin: 0.06, end: 0, duration: 400.ms, curve: Curves.easeOut);
    }
}
import 'package:flutter/material.dart';

class RegisterProgressBar extends StatelessWidget {
    final int currentStep;
    final int totalSteps;

    const RegisterProgressBar({
        super.key,
        required this.currentStep,
        required this.totalSteps,
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        'Étape $currentStep sur $totalSteps',
                        style: const TextStyle(
                            color: Color(0xFFAA9AB5),
                            fontSize: 12,
                            letterSpacing: 0.5,
                        ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: currentStep / totalSteps),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            builder: (context, value, _) => LinearProgressIndicator(
                                value: value,
                                minHeight: 6,
                                backgroundColor: const Color(0xFF2A1A35),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7B00D4)),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}

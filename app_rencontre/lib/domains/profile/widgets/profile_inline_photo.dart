import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileInlinePhoto extends StatelessWidget {
  final String url;
  final bool locked;
  final VoidCallback onTap;
  final VoidCallback onLockedTap;

  const ProfileInlinePhoto({
    super.key,
    required this.url,
    required this.locked,
    required this.onTap,
    required this.onLockedTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: locked ? onLockedTap : onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 420,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: const Color(0xFF1A0A1F)),
              ),
              if (locked) ...[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                  child: Container(color: Colors.black.withValues(alpha: 0.35)),
                ),
                const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, color: Color(0xFF7B00D4), size: 40),
                      SizedBox(height: 8),
                      Text(
                        'PREMIUM',
                        style: TextStyle(
                          color: Color(0xFF7B00D4),
                          fontSize: 12,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SwipeActionButtons extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onLike;
  final VoidCallback? onRewind;
  final VoidCallback? onBoost;
  final int boostCredits;

  const SwipeActionButtons({
    super.key,
    required this.onDislike,
    required this.onLike,
    this.onRewind,
    this.onBoost,
    this.boostCredits = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SmallButton(icon: Icons.replay, color: const Color(0xFF4A6FA5), onTap: onRewind),
          const SizedBox(width: 20),
          _CircleButton(icon: Icons.heart_broken, color: const Color(0xFF8B0000), onTap: onDislike),
          const SizedBox(width: 20),
          _CircleButton(icon: Icons.favorite, color: const Color(0xFF7B00D4), onTap: onLike),
          const SizedBox(width: 20),
          _BoostButton(onTap: onBoost, credits: boostCredits),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68, height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1A0A1F),
          border: Border.all(color: color, width: 2),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 14, spreadRadius: 2)],
        ),
        child: Icon(icon, color: color, size: 32),
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _SmallButton({required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46, height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1A0A1F),
          border: Border.all(
            color: active ? color : color.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Icon(icon, color: active ? color : color.withValues(alpha: 0.3), size: 22),
      ),
    );
  }
}

class _BoostButton extends StatelessWidget {
  final VoidCallback? onTap;
  final int credits;
  const _BoostButton({this.onTap, required this.credits});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFFFD700);
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1A0A1F),
              border: Border.all(
                color: active ? color : color.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Icon(Icons.bolt, color: active ? color : color.withValues(alpha: 0.3), size: 22),
          ),
          if (credits > 0)
            Positioned(
              top: -4, right: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(color: color, shape: BoxShape.circle),
                child: Text(
                  '$credits',
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

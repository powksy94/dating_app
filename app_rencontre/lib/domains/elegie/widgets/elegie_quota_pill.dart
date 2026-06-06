import 'package:flutter/material.dart';

class ElegieQuotaPill extends StatelessWidget {
  final int remaining;
  final int limit;
  const ElegieQuotaPill({super.key, required this.remaining, required this.limit});

  @override
  Widget build(BuildContext context) {
    final color = remaining == 0
        ? const Color(0xFFD400FF)
        : remaining <= 1
            ? const Color(0xFFFF6B35)
            : const Color(0xFF7B00D4);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        '$remaining / $limit',
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

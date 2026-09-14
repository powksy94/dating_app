import 'package:flutter/material.dart';

class RangeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valueLabel;
  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;
  const RangeTile({
    super.key,
    required this.icon,
    required this.label,
    required this.valueLabel,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF7B00D4), size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        color: Color(0xFFE8E0EE), fontSize: 14)),
              ),
              Text(valueLabel,
                  style: const TextStyle(
                      color: Color(0xFF7B00D4),
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF7B00D4),
              inactiveTrackColor: const Color(0xFF3D2A4A),
              thumbColor: const Color(0xFF7B00D4),
              overlayColor: const Color(0xFF7B00D4).withValues(alpha: 0.15),
            ),
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

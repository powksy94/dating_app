import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF7B00D4),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}

class ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const ToggleTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: const Color(0xFF7B00D4), size: 22),
        title: Text(label,
            style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 14)),
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFF7B00D4),
        inactiveTrackColor: const Color(0xFF3D2A4A),
      ),
    );
  }
}

class SliderTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  const SliderTile({
    super.key,
    required this.icon,
    required this.label,
    required this.valueLabel,
    required this.value,
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
            child: Slider(
              value: value,
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

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final Widget? trailing;
  const ActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFFE8E0EE),
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 22),
        title: Text(label, style: TextStyle(color: color, fontSize: 14)),
        trailing: trailing ??
            Icon(Icons.chevron_right,
                color: color.withValues(alpha: 0.4), size: 18),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';

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

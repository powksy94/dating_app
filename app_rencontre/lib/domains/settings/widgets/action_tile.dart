import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
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

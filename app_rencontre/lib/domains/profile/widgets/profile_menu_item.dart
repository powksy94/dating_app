import 'package:flutter/material.dart';

/// One row of the profile menu, navigating to a full screen.
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFFE8E0EE), size: 22),
      title: Text(label, style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, color: Color(0x66E8E0EE), size: 18),
    );
  }
}

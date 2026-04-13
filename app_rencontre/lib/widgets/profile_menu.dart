import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final VoidCallback onEdit;
  const ProfileMenu({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      decoration: const BoxDecoration(
        color: Color(0xFF120018),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF3D2A4A),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'MON ESPACE',
            style: TextStyle(
              color: Color(0xFF7B00D4),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          _MenuItem(
            icon: Icons.edit_outlined,
            label: 'Modifier mon profil',
            onTap: onEdit,
          ),
          _MenuItem(
            icon: Icons.favorite_border,
            label: 'Historique des likes',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/likes-history');
            },
          ),
          _MenuItem(
            icon: Icons.people_outline,
            label: 'Mes matchs',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/matches');
            },
          ),
          _MenuItem(
            icon: Icons.settings_outlined,
            label: 'Paramètres',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: const Color(0xFFE8E0EE), size: 22),
      title: Text(
        label,
        style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 15),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0x66E8E0EE),
        size: 18,
      ),
    );
  }
}

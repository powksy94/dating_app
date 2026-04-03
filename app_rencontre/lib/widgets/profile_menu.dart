import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onLogout;
  const ProfileMenu({super.key, required this.onEdit, required this.onLogout});

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
            onTap: () {},
          ),
          _MenuItem(
            icon: Icons.people_outline,
            label: 'Mes matchs',
            onTap: () => Navigator.pop(context),
          ),
          _MenuItem(
            icon: Icons.settings_outlined,
            label: 'Paramètres',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Spacer(),
          const Divider(color: Color(0xFF1A0A1F)),
          _MenuItem(
            icon: Icons.logout,
            label: 'Se déconnecter',
            color: const Color(0xFF8B0000),
            onTap: onLogout,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFFE8E0EE),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        label,
        style: TextStyle(color: color, fontSize: 15),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: color.withOpacity(0.4),
        size: 18,
      ),
    );
  }
}

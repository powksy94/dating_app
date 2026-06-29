import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
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
          Text(
            l.profileMenuTitle,
            style: const TextStyle(
              color: Color(0xFF7B00D4),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          _MenuItem(
            icon: Icons.favorite_border,
            label: l.profileMenuLikesHistory,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/likes-history');
            },
          ),
          _MenuItem(
            icon: Icons.remove_red_eye_outlined,
            label: l.profileMenuVisitors,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/visitors');
            },
          ),
          _MenuItem(
            icon: Icons.people_outline,
            label: l.profileMenuMatches,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/matches');
            },
          ),
          _MenuItem(
            icon: Icons.settings_outlined,
            label: l.profileMenuSettings,
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

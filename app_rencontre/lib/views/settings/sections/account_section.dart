import 'package:flutter/material.dart';
import '../../../widgets/settings_titles.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback onChangePassword;
  final VoidCallback onDeleteAccount;
  final VoidCallback onLogout;

  const AccountSection({
    super.key,
    required this.onChangePassword,
    required this.onDeleteAccount,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Compte'),
        ActionTile(
          icon: Icons.lock_outline,
          label: 'Changer le mot de passe',
          onTap: onChangePassword,
        ),
        ActionTile(
          icon: Icons.logout,
          label: 'Se déconnecter',
          color: const Color(0xFF8B0000),
          onTap: onLogout,
        ),
        ActionTile(
          icon: Icons.delete_outline,
          label: 'Supprimer le compte',
          color: const Color(0xFF8B0000),
          onTap: onDeleteAccount,
        ),
      ],
    );
  }
}

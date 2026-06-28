import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onChangePassword;
  final VoidCallback onDeleteAccount;
  final VoidCallback onLogout;

  const AccountSection({
    super.key,
    required this.onEditProfile,
    required this.onChangePassword,
    required this.onDeleteAccount,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionAccount),
        ActionTile(
          icon: Icons.edit_outlined,
          label: l.settingsBtnEditProfile,
          onTap: onEditProfile,
        ),
        ActionTile(
          icon: Icons.lock_outline,
          label: l.settingsBtnChangePassword,
          onTap: onChangePassword,
        ),
        ActionTile(
          icon: Icons.logout,
          label: l.settingsBtnLogout,
          color: const Color(0xFF8B0000),
          onTap: onLogout,
        ),
        ActionTile(
          icon: Icons.delete_outline,
          label: l.settingsBtnDeleteAccount,
          color: const Color(0xFF8B0000),
          onTap: onDeleteAccount,
        ),
      ],
    );
  }
}

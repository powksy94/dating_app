import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

class PrivacySection extends StatelessWidget {
  final bool profileVisible;
  final ValueChanged<bool> onVisibleChanged;

  const PrivacySection({
    super.key,
    required this.profileVisible,
    required this.onVisibleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionPrivacy),
        ToggleTile(
          icon: Icons.visibility_outlined,
          label: l.settingsPrivacyVisible,
          value: profileVisible,
          onChanged: onVisibleChanged,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Confidentialité'),
        ToggleTile(
          icon: Icons.visibility_outlined,
          label: 'Profil visible dans le swipe',
          value: profileVisible,
          onChanged: onVisibleChanged,
        ),
      ],
    );
  }
}

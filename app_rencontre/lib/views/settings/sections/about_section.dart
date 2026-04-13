import 'package:flutter/material.dart';
import '../../../widgets/settings_titles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('À propos'),
        ActionTile(
          icon: Icons.info_outline,
          label: 'Version 1.0.0',
          onTap: () {},
          trailing: const SizedBox.shrink(),
        ),
        ActionTile(
          icon: Icons.description_outlined,
          label: 'Conditions d\'utilisation',
          onTap: () {},
        ),
        ActionTile(
          icon: Icons.privacy_tip_outlined,
          label: 'Politique de confidentialité',
          onTap: () {},
        ),
      ],
    );
  }
}

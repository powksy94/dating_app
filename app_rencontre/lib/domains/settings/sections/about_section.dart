import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _openTermsOfService() =>
      launchUrl(Uri.parse('https://powksy.com/nocturne/terms-of-service'));

  Future<void> _openPrivacyPolicy() =>
      launchUrl(Uri.parse('https://powksy.com/nocturne/privacy-policy'));

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
          onTap: _openTermsOfService,
        ),
        ActionTile(
          icon: Icons.privacy_tip_outlined,
          label: 'Politique de confidentialité',
          onTap: _openPrivacyPolicy,
        ),
      ],
    );
  }
}

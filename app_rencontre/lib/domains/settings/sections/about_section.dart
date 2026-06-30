import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _openTermsOfService(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return launchUrl(Uri.parse('https://powksy.com/nocturne/terms-of-service?lang=$lang'));
  }

  Future<void> _openPrivacyPolicy(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return launchUrl(Uri.parse('https://powksy.com/nocturne/privacy-policy?lang=$lang'));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionAbout),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final version = snapshot.data?.version ?? '';
            return ActionTile(
              icon: Icons.info_outline,
              label: '${l.settingsVersionLabel} $version',
              onTap: () {},
              trailing: const SizedBox.shrink(),
            );
          },
        ),
        ActionTile(
          icon: Icons.description_outlined,
          label: l.settingsTermsOfService,
          onTap: () => _openTermsOfService(context),
        ),
        ActionTile(
          icon: Icons.privacy_tip_outlined,
          label: l.settingsPrivacyPolicy,
          onTap: () => _openPrivacyPolicy(context),
        ),
      ],
    );
  }
}

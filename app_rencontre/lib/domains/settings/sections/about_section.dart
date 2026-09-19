import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/settings/widgets/section_header.dart';
import 'package:nocturne/domains/settings/widgets/action_tile.dart';

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

  Future<void> _rateApp() async {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      await inAppReview.openStoreListing();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionAbout),
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
        ActionTile(
          icon: Icons.star_outline,
          label: l.settingsRateApp,
          onTap: _rateApp,
        ),
      ],
    );
  }
}

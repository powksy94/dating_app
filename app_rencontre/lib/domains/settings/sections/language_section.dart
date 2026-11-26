import 'package:flutter/material.dart';
import 'package:nocturne/domains/settings/widgets/action_tile.dart';
import 'package:nocturne/domains/settings/widgets/section_header.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/services/locale_override_service.dart';

const _languageNames = {
  'en': 'English',
  'fr': 'Français',
  'es': 'Español',
  'pt': 'Português (Portugal)',
  'pt_BR': 'Português (Brasil)',
  'de': 'Deutsch',
};

String _keyFor(Locale locale) => locale.countryCode != null
    ? '${locale.languageCode}_${locale.countryCode}'
    : locale.languageCode;

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  void _openPicker(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0A1F),
      builder: (sheetContext) => ValueListenableBuilder<Locale?>(
        valueListenable: LocaleOverrideService.locale,
        builder: (context, current, _) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<Locale?>(
                title: Text(l.settingsLanguageDevice),
                activeColor: const Color(0xFF7B00D4),
                value: null,
                groupValue: current,
                onChanged: (_) {
                  LocaleOverrideService.set(null);
                  Navigator.pop(sheetContext);
                },
              ),
              for (final locale in AppLocalizations.supportedLocales)
                RadioListTile<Locale?>(
                  title: Text(
                    _languageNames[_keyFor(locale)] ?? locale.languageCode,
                  ),
                  activeColor: const Color(0xFF7B00D4),
                  value: locale,
                  groupValue: current,
                  onChanged: (_) {
                    LocaleOverrideService.set(locale);
                    Navigator.pop(sheetContext);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionLanguage),
        ValueListenableBuilder<Locale?>(
          valueListenable: LocaleOverrideService.locale, 
          builder: (context, current, _) => ActionTile(
            icon: Icons.language,
            label: l.settingsLanguage,
            trailing: Text(
              current != null
                ? (_languageNames[_keyFor(current)] ?? current.languageCode)
                : l.settingsLanguageDevice,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
            ),
            onTap: () => _openPicker(context),
          ),
        ),
      ],
    );
  }
}

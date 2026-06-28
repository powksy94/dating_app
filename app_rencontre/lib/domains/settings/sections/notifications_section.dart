import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

class NotificationsSection extends StatelessWidget {
  final bool notifMatches;
  final bool notifMessages;
  final bool notifElegies;
  final ValueChanged<bool> onMatchesChanged;
  final ValueChanged<bool> onMessagesChanged;
  final ValueChanged<bool> onElegiesChanged;

  const NotificationsSection({
    super.key,
    required this.notifMatches,
    required this.notifMessages,
    required this.notifElegies,
    required this.onMatchesChanged,
    required this.onMessagesChanged,
    required this.onElegiesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionNotifications),
        ToggleTile(
          icon: Icons.favorite,
          label: l.settingsNotifMatches,
          value: notifMatches,
          onChanged: onMatchesChanged,
        ),
        ToggleTile(
          icon: Icons.chat_bubble_outline,
          label: l.settingsNotifMessages,
          value: notifMessages,
          onChanged: onMessagesChanged,
        ),
        ToggleTile(
          icon: Icons.edit_note,
          label: l.settingsNotifElegies,
          value: notifElegies,
          onChanged: onElegiesChanged,
        ),
      ],
    );
  }
}

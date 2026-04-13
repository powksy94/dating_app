import 'package:flutter/material.dart';
import '../../../widgets/settings_titles.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Notifications'),
        ToggleTile(
          icon: Icons.favorite,
          label: 'Nouveaux matchs',
          value: notifMatches,
          onChanged: onMatchesChanged,
        ),
        ToggleTile(
          icon: Icons.chat_bubble_outline,
          label: 'Nouveaux messages',
          value: notifMessages,
          onChanged: onMessagesChanged,
        ),
        ToggleTile(
          icon: Icons.edit_note,
          label: 'Élégies reçues',
          value: notifElegies,
          onChanged: onElegiesChanged,
        ),
      ],
    );
  }
}

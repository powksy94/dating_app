import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Discord has no OAuth connection yet (see
/// dev_features/oauth-social-connections.md): its pastille only explains that,
/// instead of navigating anywhere or asking for a link like the other platforms.
Future<void> showDiscordComingSoonDialog(BuildContext context) {
  final l = AppLocalizations.of(context)!;
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1A0A1F),
      title: const Text('Discord', style: TextStyle(color: Colors.white)),
      content: Text(l.profileDiscordComingSoon, style: const TextStyle(color: Color(0xFFAA9AB5))),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.commonBtnOk))],
    ),
  );
}

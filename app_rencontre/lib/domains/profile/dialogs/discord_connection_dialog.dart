import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Confirms connecting or disconnecting Discord before anything actually
/// happens (opening the browser, or revoking access). Returns 'connect',
/// 'disconnect', or null when dismissed; ProfileMenu does the actual work.
Future<String?> showDiscordConnectionDialog(
  BuildContext context, {
  required bool connected,
  String? username,
}) {
  final l = AppLocalizations.of(context)!;
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1A0A1F),
      title: const Text('Discord', style: TextStyle(color: Colors.white)),
      content: Text(
        connected ? l.profileDiscordConnectedAs(username ?? '') : l.profileDiscordConnectPrompt,
        style: const TextStyle(color: Color(0xFFAA9AB5)),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, null), child: Text(l.commonBtnCancel)),
        if (connected)
          TextButton(onPressed: () => Navigator.pop(ctx, 'disconnect'), child: Text(l.commonBtnRemove))
        else
          TextButton(onPressed: () => Navigator.pop(ctx, 'connect'), child: Text(l.profileDiscordBtnConnect)),
      ],
    ),
  );
}

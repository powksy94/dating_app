import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nocturne/l10n/app_localizations.dart';

Future<void> confirmAppExit(BuildContext context) async {
  final l = AppLocalizations.of(context)!;
  final shouldExit = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l.homeExitConfirmTitle),
      content: Text(l.homeExitConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(l.homeExitConfirmCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(l.homeExitConfirmQuit),
        ),
      ],
    ),
  );
  if (shouldExit == true) {
    SystemNavigator.pop();
  }
}

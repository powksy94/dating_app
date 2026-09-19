import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class SubscriptionDialogs {
  static Future<bool> confirmCancel(BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1A0A1F),
            title: Text(
              l.subscriptionCancelSubscription,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            content: Text(
              l.subscriptionDialogCancelBody,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l.subscriptionBtnKeep,
                    style: const TextStyle(color: Color(0xFF7B00D4))),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l.subscriptionBtnConfirmCancel,
                    style: const TextStyle(color: Color(0xFFEF4444))),
              ),
            ],
          ),
        ) ??
        false;
  }
}

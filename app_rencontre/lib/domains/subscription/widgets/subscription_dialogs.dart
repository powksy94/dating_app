import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';

class SubscriptionDialogs {
  static Future<bool> confirmSubscribe(
    BuildContext context,
    SubscriptionPlan plan,
    SubscriptionPeriod period,
  ) async {
    final l = AppLocalizations.of(context)!;
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1A0A1F),
            title: Text(
              l.subscriptionDialogSubscribeTitle(plan.name),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            content: Text(
              '${plan.priceFor(period)} / ${periodName(context, period)}',
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l.subscriptionBtnDialogCancel,
                    style: const TextStyle(color: Color(0xFF5A4A6A))),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l.subscriptionBtnDialogConfirm,
                    style: TextStyle(color: plan.accentColor)),
              ),
            ],
          ),
        ) ??
        false;
  }

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

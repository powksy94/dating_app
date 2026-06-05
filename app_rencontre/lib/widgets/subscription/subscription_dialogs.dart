import 'package:flutter/material.dart';
import '../../models/subscription_plan.dart';

class SubscriptionDialogs {
  static Future<bool> confirmSubscribe(
    BuildContext context,
    SubscriptionPlan plan,
    SubscriptionPeriod period,
  ) async {
    final labels = {
      SubscriptionPeriod.week:  'semaine',
      SubscriptionPeriod.month: 'mois',
      SubscriptionPeriod.year:  'an',
    };
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1A0A1F),
            title: Text(
              'Souscrire à ${plan.name}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            content: Text(
              '${plan.priceFor(period)} / ${labels[period]}',
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Annuler',
                    style: TextStyle(color: Color(0xFF5A4A6A))),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Confirmer',
                    style: TextStyle(color: plan.accentColor)),
              ),
            ],
          ),
        ) ??
        false;
  }

  static Future<bool> confirmCancel(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1A0A1F),
            title: const Text(
              'Résilier l\'abonnement',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            content: const Text(
              'Tu perdras accès aux fonctionnalités premium.',
              style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Garder',
                    style: TextStyle(color: Color(0xFF7B00D4))),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Résilier',
                    style: TextStyle(color: Color(0xFFEF4444))),
              ),
            ],
          ),
        ) ??
        false;
  }
}

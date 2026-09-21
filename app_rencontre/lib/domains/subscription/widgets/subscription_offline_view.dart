import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Shown instead of the subscription screen while the device is offline:
/// plans, prices and purchases all need the store, so nothing is offered
/// (or can be bought) without a connection.
class SubscriptionOfflineView extends StatelessWidget {
  const SubscriptionOfflineView({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l.subscriptionPageTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 64, color: Color(0xFF7B00D4)),
              const SizedBox(height: 16),
              Text(
                l.subscriptionOfflineTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                l.subscriptionOfflineBody,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

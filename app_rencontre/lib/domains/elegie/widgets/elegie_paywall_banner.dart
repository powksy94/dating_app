import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ElegiePaywallBanner extends StatelessWidget {
  final VoidCallback onPaywall;
  const ElegiePaywallBanner({super.key, required this.onPaywall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF7B00D4), width: 0.5),
      ),
      child: Column(
        children: [
          const Icon(Icons.lock, color: Color(0xFF7B00D4), size: 32),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.elegieLimitReachedTitle,
            style: const TextStyle(color: Color(0xFFE8E0EE), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.elegieBannerDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 12),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: onPaywall,
            icon: const Icon(Icons.auto_awesome, size: 14),
            label: Text(AppLocalizations.of(context)!.elegieBtnUpgrade),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A0072),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFF7B00D4)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

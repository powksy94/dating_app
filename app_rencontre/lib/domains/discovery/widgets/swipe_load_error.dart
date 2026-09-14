import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class SwipeLoadError extends StatelessWidget {
  final VoidCallback onRetry;
  const SwipeLoadError({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.cloud_off_outlined, size: 64, color: Color(0xFF7B00D4)),
          const SizedBox(height: 16),
          Text(
            l.discoveryLoadErrorTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            l.discoveryLoadErrorSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18, color: Color(0xFF7B00D4)),
              label: Text(l.discoveryBtnRetry, style: const TextStyle(color: Color(0xFFE8E0EE))),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFF3D2A4A)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

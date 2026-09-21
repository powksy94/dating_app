import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/services/connectivity_service.dart';

/// Slim banner shown at the top of every screen while the device has no
/// connection, so a lost connection is visible right away instead of only
/// surfacing when a screen happens to make a request. Purely informational:
/// screens keep handling their own loading/retry/error states.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ConnectivityService.online,
      builder: (context, online, _) => AnimatedSize(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        child: online ? const SizedBox(width: double.infinity) : _banner(context),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        color: const Color(0xFF7F1D1D),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 14, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context)!.commonOfflineBanner,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

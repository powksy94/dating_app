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
    // Above the Navigator there is no Material, so a bare Text would get the
    // app's fallback style (monospace, yellow double underline). The Material
    // also puts the red under the status bar, outside the SafeArea.
    return Material(
      color: const Color(0xFF7F1D1D),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 12, color: Colors.white),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.commonOfflineBanner,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

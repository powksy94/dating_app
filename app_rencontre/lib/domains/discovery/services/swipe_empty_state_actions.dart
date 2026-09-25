import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/services/swipe_service.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

/// Actions offered from the discovery empty state screen (no more profiles).
class SwipeEmptyStateActions {
  final BuildContext context;
  final VoidCallback onProfilesChanged;

  SwipeEmptyStateActions({required this.context, required this.onProfilesChanged});

  Future<void> resetLikes() async {
    final ok = await SwipeService.resetLikes();
    if (!context.mounted) return;
    if (ok) {
      onProfilesChanged();
      showAppSnackBar(context, AppLocalizations.of(context)!.discoveryEmptyResetSuccess, backgroundColor: const Color(0xFF4A0072));
    }
  }

  void waitForMoon() {
    onProfilesChanged();
    showAppSnackBar(context, AppLocalizations.of(context)!.discoveryEmptyWaitMoonMessage, backgroundColor: const Color(0xFF4A0072));
  }
}

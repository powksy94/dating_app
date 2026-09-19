import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/services/swipe_service.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.discoveryEmptyResetSuccess),
        backgroundColor: const Color(0xFF4A0072),
      ));
    }
  }

  void waitForMoon() {
    onProfilesChanged();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context)!.discoveryEmptyWaitMoonMessage),
      backgroundColor: const Color(0xFF2D0040),
    ));
  }
}

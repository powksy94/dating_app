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
      _showSnack(AppLocalizations.of(context)!.discoveryEmptyResetSuccess);
    }
  }

  void waitForMoon() {
    onProfilesChanged();
    _showSnack(AppLocalizations.of(context)!.discoveryEmptyWaitMoonMessage);
  }

  // Same styling for every message here: an explicit light text color, since
  // the theme's default SnackBar text color assumes a light background and
  // reads as near-invisible on our dark purple one otherwise.
  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF4A0072),
    ));
  }
}

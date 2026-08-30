import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/services/swipe_service.dart';
import 'package:nocturne/domains/profile/views/profil_edit_page.dart';
import 'package:nocturne/shared/services/firestore_service.dart';

/// Actions proposées depuis l'écran vide de découverte (plus de profils).
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

  Future<void> editFilters() async {
    final profile = await FirestoreService().getMyProfile();
    if (!context.mounted || profile == null) return;
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => ProfileEditPage(profile: profile)));
    if (context.mounted) onProfilesChanged();
  }

  void waitForMoon() {
    onProfilesChanged();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context)!.discoveryEmptyWaitMoonMessage),
      backgroundColor: const Color(0xFF2D0040),
    ));
  }
}

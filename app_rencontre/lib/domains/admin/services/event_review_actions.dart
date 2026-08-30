import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_event_review_service.dart';

/// Actions available from the event review list: approve or reject one
/// pending event, then update the caller's list and show feedback.
class EventReviewActions {
  final BuildContext context;
  final void Function(String eventId) onDecided;

  EventReviewActions({required this.context, required this.onDecided});

  Future<void> approve(String eventId) => _decide(eventId, true);
  Future<void> reject(String eventId) => _decide(eventId, false);

  Future<void> _decide(String eventId, bool approve) async {
    final ok = approve
        ? await AdminEventReviewService.approve(eventId)
        : await AdminEventReviewService.reject(eventId);
    if (!context.mounted || !ok) return;

    onDecided(eventId);
    final l = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(approve ? l.eventReviewApproved : l.eventReviewRejected),
      backgroundColor: approve ? const Color(0xFF4A0072) : const Color(0xFF7F1D1D),
    ));
  }
}

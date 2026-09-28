import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_photo_review_service.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

/// Actions available from the photo review list: approve or reject one
/// pending photo, then update the caller's list and show feedback.
class PhotoReviewActions {
  final BuildContext context;
  final void Function(String photoId) onDecided;

  PhotoReviewActions({required this.context, required this.onDecided});

  Future<void> approve(String photoId) => _decide(photoId, true);
  Future<void> reject(String photoId) => _decide(photoId, false);

  Future<void> _decide(String photoId, bool approve) async {
    final ok = approve
        ? await AdminPhotoReviewService.approve(photoId)
        : await AdminPhotoReviewService.reject(photoId);
    if (!context.mounted || !ok) return;

    onDecided(photoId);
    final l = AppLocalizations.of(context)!;
    showAppSnackBar(
      context,
      approve ? l.photoReviewApproved : l.photoReviewRejected,
      backgroundColor: approve ? const Color(0xFF4A0072) : const Color(0xFF7F1D1D),
    );
  }
}

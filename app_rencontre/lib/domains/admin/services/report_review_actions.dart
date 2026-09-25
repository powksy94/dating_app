import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_report_review_service.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

/// Actions available from the report review list: dismiss a report, or
/// ban/unban the reported user, then update the caller's list and show
/// feedback.
class ReportReviewActions {
  final BuildContext context;
  final void Function(String reportId) onDismissed;
  final void Function(String reportId, bool banned) onBanChanged;

  ReportReviewActions({
    required this.context,
    required this.onDismissed,
    required this.onBanChanged,
  });

  Future<void> dismiss(String reportId) async {
    final ok = await AdminReportReviewService.dismiss(reportId);
    if (!context.mounted || !ok) return;

    onDismissed(reportId);
    final l = AppLocalizations.of(context)!;
    showAppSnackBar(context, l.reportReviewDismissed, backgroundColor: const Color(0xFF4A0072));
  }

  Future<void> setBanned(String reportId, String userId, bool banned) async {
    final ok = banned
        ? await AdminReportReviewService.banUser(userId)
        : await AdminReportReviewService.unbanUser(userId);
    if (!context.mounted || !ok) return;

    onBanChanged(reportId, banned);
    final l = AppLocalizations.of(context)!;
    showAppSnackBar(
      context,
      banned ? l.reportReviewBanned : l.reportReviewUnbanned,
      backgroundColor: banned ? const Color(0xFF7F1D1D) : const Color(0xFF4A0072),
    );
  }
}

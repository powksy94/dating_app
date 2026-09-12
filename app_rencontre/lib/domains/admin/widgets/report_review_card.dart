import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ReportReviewCard extends StatelessWidget {
  final Map<String, dynamic> report;
  final VoidCallback onDismiss;
  final VoidCallback onToggleBan;

  const ReportReviewCard({
    super.key,
    required this.report,
    required this.onDismiss,
    required this.onToggleBan,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final reporter = report['reporter'] as Map<String, dynamic>? ?? {};
    final reported = report['reported'] as Map<String, dynamic>? ?? {};
    final reporterName = reporter['username'] as String? ?? '?';
    final reportedName = reported['username'] as String? ?? '?';
    final banned       = reported['banned'] as bool? ?? false;
    final reason       = report['reason'] as String? ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D0040)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(reportedName,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              if (banned)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F1D1D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(l.reportReviewBannedBadge,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text('${l.reportReviewReporterLabel} $reporterName',
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
          const SizedBox(height: 10),
          Text(l.reportReviewReasonLabel,
              style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(reason,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onDismiss,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFAA9AB5),
                  side: const BorderSide(color: Color(0xFF3D2A4A)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.reportReviewBtnDismiss),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: onToggleBan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: banned ? const Color(0xFF4A0072) : const Color(0xFF7F1D1D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(banned ? l.reportReviewBtnUnban : l.reportReviewBtnBan),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

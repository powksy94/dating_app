import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ReportReviewCard extends StatelessWidget {
  final Map<String, dynamic> report;
  final VoidCallback onTap;

  const ReportReviewCard({
    super.key,
    required this.report,
    required this.onTap,
  });

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes}min';
    if (diff.inHours < 24)   return 'il y a ${diff.inHours}h';
    return 'il y a ${diff.inDays}j';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final reporter = report['reporter'] as Map<String, dynamic>? ?? {};
    final reported = report['reported'] as Map<String, dynamic>? ?? {};
    final reporterName = reporter['username'] as String? ?? '?';
    final reportedName = reported['username'] as String? ?? '?';
    final banned       = reported['banned'] as bool? ?? false;
    final reason       = report['reason'] as String? ?? '';
    final createdAt    = DateTime.tryParse(report['createdAt'] as String? ?? '');

    return Material(
      color: const Color(0xFF1A0A1F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2D0040)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF2D0040),
                child: Text(
                  reportedName.isNotEmpty ? reportedName[0].toUpperCase() : '?',
                  style: const TextStyle(color: Color(0xFF7B00D4), fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(reportedName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        if (banned) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7F1D1D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(l.reportReviewBannedBadge,
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                          ),
                        ],
                        if (createdAt != null) ...[
                          const SizedBox(width: 6),
                          Text(_timeAgo(createdAt),
                              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('${l.reportReviewReporterLabel} $reporterName',
                        style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
                    const SizedBox(height: 8),
                    Text(reason,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Color(0xFF5A4A6A), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

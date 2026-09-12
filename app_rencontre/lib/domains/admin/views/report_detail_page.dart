import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/report_review_actions.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';

class ReportDetailPage extends StatefulWidget {
  final Map<String, dynamic> report;
  const ReportDetailPage({super.key, required this.report});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  late bool _banned;

  @override
  void initState() {
    super.initState();
    final reported = widget.report['reported'] as Map<String, dynamic>;
    _banned = reported['banned'] as bool? ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final reportId  = widget.report['id'] as String;
    final reporter  = widget.report['reporter'] as Map<String, dynamic>;
    final reported  = widget.report['reported'] as Map<String, dynamic>;
    final reason    = widget.report['reason'] as String? ?? '';
    final createdAt = DateTime.tryParse(widget.report['createdAt'] as String? ?? '');

    final actions = ReportReviewActions(
      context: context,
      onDismissed: (_) => Navigator.pop(context, {'action': 'dismissed'}),
      onBanChanged: (_, banned) {
        setState(() => _banned = banned);
        Navigator.pop(context, {'action': 'banChanged', 'banned': banned});
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0010),
        elevation: 0,
        title: Text(l.reportDetailTitle,
            style: const TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
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
                      child: Text(reported['username'] as String? ?? '?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    if (_banned)
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
                const SizedBox(height: 4),
                Text('${l.reportReviewReporterLabel} ${reporter['username'] as String? ?? '?'}',
                    style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
                if (createdAt != null) ...[
                  const SizedBox(height: 2),
                  Text('${l.reportDetailDateLabel} ${formatEventDateCompact(context, createdAt)}',
                      style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
                ],
                const SizedBox(height: 20),
                Text(l.reportReviewReasonLabel,
                    style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(reason,
                    style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 14, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => actions.dismiss(reportId),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFAA9AB5),
                  side: const BorderSide(color: Color(0xFF3D2A4A)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.reportReviewBtnDismiss),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => actions.setBanned(
                  reportId, reported['id'] as String, !_banned,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _banned ? const Color(0xFF4A0072) : const Color(0xFF7F1D1D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(_banned ? l.reportReviewBtnUnban : l.reportReviewBtnBan),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

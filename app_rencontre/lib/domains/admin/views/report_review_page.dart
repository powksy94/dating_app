import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_report_review_service.dart';
import 'package:nocturne/domains/admin/services/report_review_actions.dart';
import 'package:nocturne/domains/admin/widgets/report_review_card.dart';

class ReportReviewPage extends StatefulWidget {
  const ReportReviewPage({super.key});

  @override
  State<ReportReviewPage> createState() => _ReportReviewPageState();
}

class _ReportReviewPageState extends State<ReportReviewPage> {
  List<Map<String, dynamic>> _reports = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final reports = await AdminReportReviewService.getPending();
    if (mounted) setState(() { _reports = reports; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final actions = ReportReviewActions(
      context: context,
      onDismissed: (reportId) => setState(() => _reports.removeWhere((r) => r['id'] == reportId)),
      onBanChanged: (reportId, banned) => setState(() {
        final report = _reports.firstWhere((r) => r['id'] == reportId);
        (report['reported'] as Map<String, dynamic>)['banned'] = banned;
      }),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0010),
        elevation: 0,
        title: Text(l.reportReviewTitle,
            style: const TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7B00D4)))
          : _reports.isEmpty
              ? Center(
                  child: Text(l.reportReviewEmpty,
                      style: const TextStyle(color: Color(0xFFAA9AB5))))
              : RefreshIndicator(
                  onRefresh: _load,
                  color: const Color(0xFF7B00D4),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _reports.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final report   = _reports[i];
                      final reported = report['reported'] as Map<String, dynamic>;
                      final banned   = reported['banned'] as bool? ?? false;
                      return ReportReviewCard(
                        report: report,
                        onDismiss: () => actions.dismiss(report['id'] as String),
                        onToggleBan: () => actions.setBanned(
                          report['id'] as String,
                          reported['id'] as String,
                          !banned,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

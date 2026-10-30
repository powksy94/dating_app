import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/social/widgets/report_reason_tree.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_header.dart';

/// First step: pick a top-level report category. Leaf categories submit
/// immediately; others drill into their sub-categories.
class ReportFlowRootView extends StatelessWidget {
  final String username;
  final String? messageSnapshot;
  final bool sending;
  final void Function(ReportCategory category) onSelect;
  const ReportFlowRootView({
    super.key,
    required this.username,
    required this.sending,
    required this.onSelect,
    this.messageSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      key: const ValueKey('root'),
      mainAxisSize: MainAxisSize.min,
      children: [
        ReportFlowHeader(title: l.socialReportHeaderTitle(username)),
        if (messageSnapshot != null && messageSnapshot!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0010),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2D0040)),
              ),
              child: Text('"$messageSnapshot"',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13, fontStyle: FontStyle.italic)),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(
            messageSnapshot != null ? l.socialReportRootQuestionMessage : l.socialReportRootQuestion,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
          ),
        ),
        ...reportTree(context).map((cat) => ListTile(
              title: Text(cat.label, style: const TextStyle(color: Colors.white, fontSize: 14)),
              trailing: cat.isLeaf
                  ? null
                  : const Icon(Icons.chevron_right, color: Color(0xFF5A4A6A), size: 18),
              onTap: sending ? null : () => onSelect(cat),
            )),
        const SizedBox(height: 8),
      ],
    );
  }
}

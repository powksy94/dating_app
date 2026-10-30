import 'package:flutter/material.dart';
import 'package:nocturne/domains/social/widgets/report_reason_tree.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_header.dart';

/// Second step for a category that has sub-reasons: pick the precise one,
/// which submits immediately.
class ReportFlowSubsView extends StatelessWidget {
  final ReportCategory category;
  final bool sending;
  final VoidCallback onBack;
  final void Function(String sub) onSelect;
  const ReportFlowSubsView({
    super.key,
    required this.category,
    required this.sending,
    required this.onBack,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('subs'),
      mainAxisSize: MainAxisSize.min,
      children: [
        ReportFlowHeader(title: category.label, showBack: true, onBack: onBack),
        const SizedBox(height: 4),
        ...category.subs.map((sub) => ListTile(
              title: Text(sub, style: const TextStyle(color: Colors.white, fontSize: 14)),
              onTap: sending ? null : () => onSelect(sub),
            )),
        const SizedBox(height: 8),
      ],
    );
  }
}

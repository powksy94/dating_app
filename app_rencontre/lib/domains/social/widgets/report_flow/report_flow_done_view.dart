import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Final step: confirms the report was sent.
class ReportFlowDoneView extends StatelessWidget {
  const ReportFlowDoneView({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      key: const ValueKey('done'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        const Icon(Icons.check_circle_outline, color: Color(0xFF7B00D4), size: 56),
        const SizedBox(height: 16),
        Text(l.socialReportSentTitle,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            l.socialReportSentBody,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.socialBtnClose, style: const TextStyle(color: Color(0xFF7B00D4))),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

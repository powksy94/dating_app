import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_header.dart';

/// Free-text step for the "Other" category.
class ReportFlowTextFieldView extends StatelessWidget {
  final String categoryLabel;
  final TextEditingController controller;
  final bool sending;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  const ReportFlowTextFieldView({
    super.key,
    required this.categoryLabel,
    required this.controller,
    required this.sending,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      key: const ValueKey('text'),
      mainAxisSize: MainAxisSize.min,
      children: [
        ReportFlowHeader(title: categoryLabel, showBack: true, onBack: onBack),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 3,
            maxLength: 300,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: l.socialReportHint,
              hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
              filled: true,
              fillColor: const Color(0xFF0D0010),
              counterStyle: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF7B00D4))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: sending ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: sending
                  ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                  : Text(l.socialBtnSendReport, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}

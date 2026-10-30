import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Shows the message a report was filed from, if any — a quoted snapshot
/// captured server-side at report time so it survives the message later
/// being deleted.
class ReportedMessageBlock extends StatelessWidget {
  final String messageSnapshot;
  const ReportedMessageBlock({super.key, required this.messageSnapshot});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(l.reportReviewMessageLabel,
            style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0010),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF2D0040)),
          ),
          child: Text('"$messageSnapshot"',
              style: const TextStyle(
                  color: Color(0xFFAA9AB5), fontSize: 13, fontStyle: FontStyle.italic, height: 1.4)),
        ),
      ],
    );
  }
}

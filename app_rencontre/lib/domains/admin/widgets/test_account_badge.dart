import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Small badge shown next to a reporter or reported user's name in the
/// moderation review, when that account is a test account (internal/closed
/// testing). Never hides a report, just flags it as likely noise.
class TestAccountBadge extends StatelessWidget {
  const TestAccountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF3D2A4A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        AppLocalizations.of(context)!.reportReviewTestAccountBadge,
        style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}

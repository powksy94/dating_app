import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

Future<void> showComingSoonDialog(BuildContext context, {required String message}) {
  final l = AppLocalizations.of(context)!;
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: const Color(0xFF1A0A1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: Color(0xFF3D2A4A)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.nightlight, size: 44, color: Color(0xFF7B00D4)),
            const SizedBox(height: 16),
            Text(
              l.commonComingSoon,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B00D4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(l.commonBtnOk),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

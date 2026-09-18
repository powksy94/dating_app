import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class UpdateRequiredPage extends StatelessWidget {
  const UpdateRequiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.nightlight, size: 72, color: Color(0xFF7B00D4)),
                  const SizedBox(height: 24),
                  Text(
                    l.updateRequiredTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l.updateRequiredBody,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => InAppReview.instance.openStoreListing(),
                      child: Text(l.updateRequiredBtn),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

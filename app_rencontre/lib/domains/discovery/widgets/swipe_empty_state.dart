import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class SwipeEmptyState extends StatelessWidget {
  const SwipeEmptyState({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.nightlight, size: 64, color: Color(0xFF7B00D4)),
      const SizedBox(height: 16),
      Text(
        AppLocalizations.of(context)!.discoveryEmptyProfiles,
        style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
      ),
    ]),
  );
}

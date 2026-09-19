import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class FiltersPanelHeader extends StatelessWidget {
  final VoidCallback onClose;
  const FiltersPanelHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.discoveryFiltersTitle,
              style: const TextStyle(
                color: Color(0xFF7B00D4),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20, color: Color(0xFFAA9AB5)),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

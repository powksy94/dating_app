import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Shown when the events list has nothing to display for the current filter.
class EventsEmptyState extends StatelessWidget {
  /// True when no category filter is applied (the whole zone is empty).
  final bool isAllFilter;

  const EventsEmptyState({super.key, required this.isAllFilter});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.event_busy, size: 48, color: Color(0xFF3D2A4A)),
          const SizedBox(height: 12),
          Text(
            isAllFilter ? l.eventEmptyZone : l.eventEmptyCategory,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

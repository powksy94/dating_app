import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// Distance slider and genre toggle shown under the events app bar.
class EventFilterPanel extends StatelessWidget {
  final double maxDistance;
  final bool filterGenres;
  final ValueChanged<double> onDistanceChanged;
  final VoidCallback onDistanceChangeEnd;
  final ValueChanged<bool> onGenresChanged;

  const EventFilterPanel({
    super.key,
    required this.maxDistance,
    required this.filterGenres,
    required this.onDistanceChanged,
    required this.onDistanceChangeEnd,
    required this.onGenresChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      color: const Color(0xFF1A0A1F),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l.eventLabelMaxDistance,
                  style: const TextStyle(color: Colors.white, fontSize: 13)),
              Text(l.eventValueKm(maxDistance.round()),
                  style: const TextStyle(
                      color: Color(0xFF7B00D4), fontSize: 13)),
            ],
          ),
          Slider(
            value: maxDistance,
            min: 5,
            max: 300,
            divisions: 59,
            activeColor: const Color(0xFF7B00D4),
            inactiveColor: const Color(0xFF3D2A4A),
            onChanged: onDistanceChanged,
            onChangeEnd: (_) => onDistanceChangeEnd(),
          ),
          const SizedBox(height: 4),
          Text(l.eventLabelGenres,
              style: const TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            children: [
              _GenreToggle(
                label:  l.eventFilterAllGenres,
                active: !filterGenres,
                onTap:  () => onGenresChanged(false),
              ),
              const SizedBox(width: 10),
              _GenreToggle(
                label:  l.eventFilterMyGenres,
                active: filterGenres,
                onTap:  () => onGenresChanged(true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenreToggle extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _GenreToggle({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? const Color(0xFF7B00D4) : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: active ? const Color(0xFF7B00D4) : const Color(0xFF3D2A4A),
            ),
          ),
          child: Text(label,
              style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF5A4A6A),
                  fontSize: 12)),
        ),
      ),
    );
  }
}

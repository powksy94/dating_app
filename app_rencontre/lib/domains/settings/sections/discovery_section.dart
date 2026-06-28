import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

class DiscoverySection extends StatelessWidget {
  final double maxDistance;
  final RangeValues ageRange;
  final ValueChanged<double> onDistanceChanged;
  final ValueChanged<RangeValues> onAgeRangeChanged;

  const DiscoverySection({
    super.key,
    required this.maxDistance,
    required this.ageRange,
    required this.onDistanceChanged,
    required this.onAgeRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionDiscovery),
        SliderTile(
          icon: Icons.location_on_outlined,
          label: l.settingsLabelMaxDistance,
          valueLabel: l.settingsValueKm(maxDistance.round()),
          value: maxDistance,
          min: 5,
          max: 200,
          onChanged: onDistanceChanged,
        ),
        RangeTile(
          icon: Icons.people_outline,
          label: l.settingsLabelAgeRange,
          valueLabel: l.settingsValueAgeRange(ageRange.start.round(), ageRange.end.round()),
          values: ageRange,
          min: 18,
          max: 80,
          onChanged: onAgeRangeChanged,
        ),
      ],
    );
  }
}

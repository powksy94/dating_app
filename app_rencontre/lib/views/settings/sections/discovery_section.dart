import 'package:flutter/material.dart';
import '../../../widgets/settings/settings_titles.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Découverte'),
        SliderTile(
          icon: Icons.location_on_outlined,
          label: 'Distance max',
          valueLabel: '${maxDistance.round()} km',
          value: maxDistance,
          min: 5,
          max: 200,
          onChanged: onDistanceChanged,
        ),
        RangeTile(
          icon: Icons.people_outline,
          label: 'Tranche d\'âge',
          valueLabel: '${ageRange.start.round()} – ${ageRange.end.round()} ans',
          values: ageRange,
          min: 18,
          max: 80,
          onChanged: onAgeRangeChanged,
        ),
      ],
    );
  }
}

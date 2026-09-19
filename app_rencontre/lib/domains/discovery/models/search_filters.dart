import 'dart:math' as math;
import 'package:flutter/material.dart' show RangeValues;
import 'package:nocturne/domains/profile/models/alternative_profile.dart';

/// Discovery filters stored on the profile, which is what the backend swipe
/// feed reads (same fields as the profile preferences screen).
class SearchFilters {
  static const ageLimitMin      = 18.0;
  static const ageLimitMax      = 80.0;
  static const distanceLimitMin = 5.0;
  static const distanceLimitMax = 300.0;

  final RangeValues ageRange;
  final double maxDistance;

  const SearchFilters({required this.ageRange, required this.maxDistance});

  /// Clamps the profile values to the slider bounds so the sliders never assert.
  factory SearchFilters.fromProfile(AlternativeProfile profile) {
    final low  = profile.ageMin.clamp(ageLimitMin, ageLimitMax).toDouble();
    final high = profile.ageMax.clamp(ageLimitMin, ageLimitMax).toDouble();
    return SearchFilters(
      ageRange: RangeValues(math.min(low, high), math.max(low, high)),
      maxDistance: profile.maxDistance
          .clamp(distanceLimitMin, distanceLimitMax)
          .toDouble(),
    );
  }

  SearchFilters copyWith({RangeValues? ageRange, double? maxDistance}) =>
      SearchFilters(
        ageRange:    ageRange    ?? this.ageRange,
        maxDistance: maxDistance ?? this.maxDistance,
      );

  Map<String, dynamic> toProfileJson() => {
        'ageMin':      ageRange.start.round(),
        'ageMax':      ageRange.end.round(),
        'maxDistance': maxDistance.round(),
      };
}

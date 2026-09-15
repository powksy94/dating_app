import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/address_result.dart';

AddressResult _fromFeature(Map<String, dynamic> feature) {
  final props = feature['properties'] as Map<String, dynamic>? ?? {};
  final coords = (feature['geometry']?['coordinates'] as List?) ?? [0, 0];
  return AddressResult(
    displayName: props['label'] ?? '',
    city:        props['city'] ?? '',
    lat:         double.parse(coords[1].toString()),
    lng:         double.parse(coords[0].toString()),
  );
}

/// Geocoding via the French government's Adresse API (api-adresse.data.gouv.fr):
/// free, no API key required, and much more precise than Nominatim for
/// French addresses. Returns nothing for an address outside of France.
class FrenchAddressService {
  static Future<List<AddressResult>> search(String query) async {
    if (query.length < 3) return [];
    try {
      final res = await http.get(
        Uri.parse('https://api-adresse.data.gouv.fr/search/').replace(
          queryParameters: {'q': query, 'limit': '5'},
        ),
      );
      if (res.statusCode != 200) return [];
      final features = (jsonDecode(res.body)['features'] as List?) ?? [];
      return features.map((f) => _fromFeature(f)).toList();
    } catch (_) {
      return [];
    }
  }
}

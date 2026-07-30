import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/address_result.dart';

AddressResult _fromNominatimJson(Map<String, dynamic> j) {
  final address = j['address'] as Map<String, dynamic>? ?? {};
  final city = address['city'] ??
      address['town'] ??
      address['village'] ??
      address['municipality'] ??
      '';
  return AddressResult(
    displayName: j['display_name'] ?? '',
    city:        city.toString(),
    lat:         double.parse(j['lat'].toString()),
    lng:         double.parse(j['lon'].toString()),
  );
}

/// Géocodage mondial via OpenStreetMap. Couverture globale mais moins précis
/// que les API nationales dédiées (ex: l'API Adresse française).
class NominatimService {
  static Future<List<AddressResult>> search(String query) async {
    if (query.length < 3) return [];
    try {
      final res = await http.get(
        Uri.parse('https://nominatim.openstreetmap.org/search').replace(
          queryParameters: {
            'q': query,
            'format': 'json',
            'limit': '5',
            'addressdetails': '1',
          },
        ),
        headers: {'User-Agent': 'NocturneApp/1.0'},
      );
      if (res.statusCode != 200) return [];
      final list = jsonDecode(res.body) as List<dynamic>;
      return list.map((e) => _fromNominatimJson(e)).toList();
    } catch (_) {
      return [];
    }
  }
}

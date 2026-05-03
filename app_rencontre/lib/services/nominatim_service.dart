import 'dart:convert';
import 'package:http/http.dart' as http;

class NominatimResult {
  final String displayName;
  final String city;
  final double lat;
  final double lng;

  const NominatimResult({
    required this.displayName,
    required this.city,
    required this.lat,
    required this.lng,
  });

  factory NominatimResult.fromJson(Map<String, dynamic> j) {
    final address = j['address'] as Map<String, dynamic>? ?? {};
    final city = address['city'] ??
        address['town'] ??
        address['village'] ??
        address['municipality'] ??
        '';
    return NominatimResult(
      displayName: j['display_name'] ?? '',
      city:        city.toString(),
      lat:         double.parse(j['lat'].toString()),
      lng:         double.parse(j['lon'].toString()),
    );
  }
}

class NominatimService {
  static Future<List<NominatimResult>> search(String query) async {
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
      return list.map((e) => NominatimResult.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }
}

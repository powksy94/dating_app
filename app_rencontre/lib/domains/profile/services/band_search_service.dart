import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// One artist returned by a search, before the user has picked it.
class BandSearchResult {
  final String id;
  final String name;
  final String? imageUrl;

  const BandSearchResult({required this.id, required this.name, this.imageUrl});

  factory BandSearchResult.fromJson(Map<String, dynamic> json) => BandSearchResult(
        id:       json['id'] as String? ?? '',
        name:     json['name'] as String? ?? '',
        imageUrl: json['imageUrl'] as String?,
      );
}

class BandSearchService {
  /// Searches Spotify's artist catalog through the backend. Always an empty
  /// list on failure (no match, Spotify not configured, request timed out):
  /// the caller falls back to a plain typed name either way, this is never
  /// shown as an error.
  static Future<List<BandSearchResult>> search(String query) async {
    try {
      final headers = await ApiService.authHeaders();
      final uri = Uri.parse('${ApiService.baseUrl}/profile/bands/search')
          .replace(queryParameters: {'q': query});
      final res = await http.get(uri, headers: headers).timeout(const Duration(seconds: 6));
      if (res.statusCode != 200) return [];
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final results = data['results'] as List? ?? [];
      return results
          .map((e) => BandSearchResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }
}

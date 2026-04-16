import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import 'api_service.dart';

class EventService {
  static Future<List<EventModel>> getEvents({
    double? lat,
    double? lng,
    double? maxDistance,
  }) async {
    final token = await ApiService.getToken();
    final params = <String, String>{};
    if (lat != null)          params['lat']         = lat.toString();
    if (lng != null)          params['lng']         = lng.toString();
    if (maxDistance != null)  params['maxDistance'] = maxDistance.toString();

    final uri = Uri.parse('${ApiService.baseUrl}/events')
        .replace(queryParameters: params.isEmpty ? null : params);

    final res = await http.get(uri,
        headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode != 200) return [];
    final list = jsonDecode(res.body) as List<dynamic>;
    return list.map((e) => EventModel.fromJson(e)).toList();
  }

  static Future<bool> attendEvent(String eventId) async {
    final token = await ApiService.getToken();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/events/$eventId/attend'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return res.statusCode == 200;
  }

  static Future<bool> unattendEvent(String eventId) async {
    final token = await ApiService.getToken();
    final res = await http.delete(
      Uri.parse('${ApiService.baseUrl}/events/$eventId/attend'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return res.statusCode == 200;
  }

  static Future<String?> createEvent({
    required String title,
    required String description,
    required DateTime date,
    required String city,
    required String address,
    required double lat,
    required double lng,
    required List<String> genres,
    required int capacityMin,
    int? capacityMax,
    required bool isFree,
    double? price,
    String? coverImagePath,
  }) async {
    final token = await ApiService.getToken();
    final req = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/events'),
    )
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['title']       = title
      ..fields['description'] = description
      ..fields['date']        = date.toIso8601String()
      ..fields['city']        = city
      ..fields['address']     = address
      ..fields['lat']         = lat.toString()
      ..fields['lng']         = lng.toString()
      ..fields['genres']      = genres.join(',')
      ..fields['capacityMin'] = capacityMin.toString()
      ..fields['isFree']      = isFree.toString();

      if (capacityMax != null) {
        req.fields['capacityMax'] = capacityMax.toString();
      }
      if (!isFree && price != null) {
        req.fields['price'] = price.toString();
      }
      if (coverImagePath != null) {
        req.files.add(await http.MultipartFile.fromPath('cover', coverImagePath));
      }

      final stream = await req.send();
      if (stream.statusCode == 201) return null;
      final body = await stream.stream.bytesToString();
      try {
        return jsonDecode(body)['message'] ?? 'Erreur inconnue';
      } catch (_) {
        return 'Erreur inconnue';
      }
  }
}
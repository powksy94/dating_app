import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/elegie.dart';
import 'api_service.dart';

class ElegieService {
  /// Retourne le matchId si l'élégie a déclenché un match, null sinon
  static Future<String?> sendElegie(String targetId, String text) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/elegie/$targetId'),
      headers: headers,
      body: jsonEncode({'text': text}),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data['match'] == true) return (data['matchId'] as String?) ?? '';
    }
    return null;
  }

  static Future<List<Elegie>> getReceived() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/elegie/received'),
      headers: headers,
    );
    if (res.statusCode != 200) return [];
    final List data = jsonDecode(res.body);
    return data.map((e) => Elegie.fromReceivedJson(e)).toList();
  }

  static Future<List<Elegie>> getSent() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/elegie/sent'),
      headers: headers,
    );
    if (res.statusCode != 200) return [];
    final List data = jsonDecode(res.body);
    return data.map((e) => Elegie.fromSentJson(e)).toList();
  }
}

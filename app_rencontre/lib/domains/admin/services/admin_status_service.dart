import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

class AdminStatusService {
  static Future<bool> isLinkedAdmin() async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.get(
        Uri.parse('${ApiService.baseUrl}/users/me/is-admin'),
        headers: headers,
      );
      if (res.statusCode == 200) {
        return (jsonDecode(res.body) as Map<String, dynamic>)['isAdmin'] as bool? ?? false;
      }
    } catch (_) {}
    return false;
  }
}

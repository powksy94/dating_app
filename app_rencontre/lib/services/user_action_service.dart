import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class UserActionService {
  static Future<bool> blockUser(String userId) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/users/$userId/block'),
      headers: headers,
    );
    return res.statusCode == 200;
  }

  static Future<bool> reportUser(String userId, String reason) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/users/$userId/report'),
      headers: headers,
      body: jsonEncode({'reason': reason}),
    );
    return res.statusCode == 200;
  }
}

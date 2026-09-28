import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// Review of pending photos from the linked admin's mobile account.
class AdminPhotoReviewService {
  static Future<List<Map<String, dynamic>>> getPending() async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.get(
        Uri.parse('${ApiService.baseUrl}/profile/photos/mobile-review'),
        headers: headers,
      );
      if (res.statusCode == 200) {
        return (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return [];
  }

  static Future<bool> approve(String photoId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/profile/photos/mobile-review/$photoId/approve'),
        headers: headers,
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> reject(String photoId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/profile/photos/mobile-review/$photoId/reject'),
        headers: headers,
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

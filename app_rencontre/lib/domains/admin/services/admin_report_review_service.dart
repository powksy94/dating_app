import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// Review of pending user reports from the linked admin's mobile account.
class AdminReportReviewService {
  static Future<List<Map<String, dynamic>>> getPending() async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.get(
        Uri.parse('${ApiService.baseUrl}/reports/mobile-review'),
        headers: headers,
      );
      if (res.statusCode == 200) {
        return (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return [];
  }

  static Future<bool> dismiss(String reportId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.delete(
        Uri.parse('${ApiService.baseUrl}/reports/mobile-review/$reportId'),
        headers: headers,
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> banUser(String userId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/reports/mobile-review/users/$userId/ban'),
        headers: headers,
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> unbanUser(String userId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/reports/mobile-review/users/$userId/unban'),
        headers: headers,
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

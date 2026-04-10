import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class SubscriptionService {
  static Future<Map<String, String>> getMySubscription() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/subscription'),
      headers: headers,
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final plan   = data['plan']   as String;
      final period = data['period'] as String;
      await _saveLocally(plan, period);
      return {'plan': plan, 'period': period};
    }
    return {'plan': 'ombre', 'period': 'month'};
  }

  static Future<void> _saveLocally(String plan, String period) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sub_plan', plan);
    await prefs.setString('sub_period', period);
  }

  static Future<String> getCachedPlan() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('sub_plan') ?? 'ombre';
  }

  /// Nombre de photos visibles sur les profils des autres
  static int photoLimit(String plan) =>
      plan == 'ombre' ? 2 : 6;
}

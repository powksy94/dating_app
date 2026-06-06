import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nocturne/shared/services/api_service.dart';

class SubscriptionService {
    static Future<Map<String, String>> getMySubscription() async {
        final headers = await ApiService.authHeaders();
        final res = await http.get(
            Uri.parse('${ApiService.baseUrl}/subscription'),
            headers: headers,
        );
        if (res.statusCode == 200) {
            final data   = jsonDecode(res.body);
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

    static Future<bool> subscribe(String plan, String period) async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.post(
                Uri.parse('${ApiService.baseUrl}/subscription/subscribe'),
                headers: headers,
                body: jsonEncode({'plan': plan, 'period': period}),
            );
            if (res.statusCode == 200) {
                await _saveLocally(plan, period);
                return true;
            }
        } catch (_) {}
        return false;
    }

    static Future<bool> cancel() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.post(
                Uri.parse('${ApiService.baseUrl}/subscription/cancel'),
                headers: headers,
            );
            if (res.statusCode == 200) {
                await _saveLocally('ombre', 'month');
                return true;
            }
        } catch (_) {}
        return false;
    }

    static Future<String> getCachedPlan() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('sub_plan') ?? 'ombre';
    }

    static int photoLimit(String plan) => plan == 'ombre' ? 2 : 6;
}

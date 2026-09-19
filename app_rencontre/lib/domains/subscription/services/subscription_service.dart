import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nocturne/shared/services/api_service.dart';

class SubscriptionService {
    static Future<Map<String, String>> getMySubscription() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/subscription'),
                headers: headers,
            ).timeout(const Duration(seconds: 10));
            if (res.statusCode == 200) {
                final data   = jsonDecode(res.body);
                final plan   = data['plan']   as String;
                final period = data['period'] as String;
                await _saveLocally(plan, period);
                return {'plan': plan, 'period': period};
            }
        } catch (_) {}
        // Offline, timeout or server error: fall back to the last known
        // subscription so the screen still opens instead of loading forever.
        final prefs = await SharedPreferences.getInstance();
        return {
            'plan':   prefs.getString('sub_plan')   ?? 'ombre',
            'period': prefs.getString('sub_period') ?? 'month',
        };
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

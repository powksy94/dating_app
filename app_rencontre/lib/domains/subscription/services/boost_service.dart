import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

class BoostService {
    /// {available, period} — period: 'month' | 'week' | null
    static Future<Map<String, dynamic>> getStatus() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/boost'),
                headers: headers,
            );
            if (res.statusCode == 200) return jsonDecode(res.body) as Map<String, dynamic>;
        } catch (_) {}
        return {'available': 0, 'period': null};
    }

    /// Uses a boost. Returns {ok, remaining, boostedUntil} or null on error/limit reached.
    static Future<Map<String, dynamic>?> useBoost() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.post(
                Uri.parse('${ApiService.baseUrl}/boost'),
                headers: headers,
            );
            if (res.statusCode == 200) return jsonDecode(res.body) as Map<String, dynamic>;
        } catch (_) {}
        return null;
    }
}

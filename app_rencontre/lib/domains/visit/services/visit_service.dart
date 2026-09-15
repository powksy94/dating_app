import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

class VisitService {
    /// List of profile visitors (last 30 days). Requires Nocturne/Abyssal.
    /// [forbidden] = true if the plan is insufficient (403).
    static Future<({List<Map<String, dynamic>> visitors, bool forbidden})> getMyVisitors() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/visits'),
                headers: headers,
            );
            if (res.statusCode == 200) {
                final list = (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
                return (visitors: list, forbidden: false);
            }
            if (res.statusCode == 403) return (visitors: <Map<String, dynamic>>[], forbidden: true);
        } catch (_) {}
        return (visitors: <Map<String, dynamic>>[], forbidden: false);
    }
}

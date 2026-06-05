import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class VisitService {
    /// Liste des visiteurs du profil (30 derniers jours). Nécessite Nocturne/Abyssal.
    static Future<List<Map<String, dynamic>>> getMyVisitors() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/visits'),
                headers: headers,
            );
            if (res.statusCode == 200) {
                return List<Map<String, dynamic>>.from(jsonDecode(res.body));
            }
        } catch (_) {}
        return [];
    }
}

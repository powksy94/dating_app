import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

class SwipeService {
    /// {limit, remaining, unlimited}
    static Future<Map<String, dynamic>> getStatus() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/swipe/status'),
                headers: headers,
            );
            if (res.statusCode == 200) return jsonDecode(res.body) as Map<String, dynamic>;
        } catch (_) {}
        return {'unlimited': true, 'limit': null, 'remaining': null};
    }

    /// Annule le dernier like. Retourne le userId rewind ou null si erreur/plan insuffisant.
    static Future<String?> rewind() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.delete(
                Uri.parse('${ApiService.baseUrl}/swipe/rewind'),
                headers: headers,
            );
            if (res.statusCode == 200) {
                return jsonDecode(res.body)['rewindedUserId'] as String?;
            }
        } catch (_) {}
        return null;
    }

    /// Liste des utilisateurs qui ont liké le profil courant (Nocturne/Abyssal).
    static Future<List<Map<String, dynamic>>> getWhoLikedMe() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/swipe/who-liked-me'),
                headers: headers,
            );
            if (res.statusCode == 200) {
                return List<Map<String, dynamic>>.from(jsonDecode(res.body));
            }
        } catch (_) {}
        return [];
    }
}

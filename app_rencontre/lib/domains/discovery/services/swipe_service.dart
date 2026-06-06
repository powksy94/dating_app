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

    /// Like un profil via l'API. Retourne {matchId?, limitReached}.
    static Future<Map<String, dynamic>> like(String targetId) async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.post(
                Uri.parse('${ApiService.baseUrl}/swipe/like/$targetId'),
                headers: headers,
            );
            if (res.statusCode == 429) return {'limitReached': true};
            if (res.statusCode == 200) {
                final data = jsonDecode(res.body) as Map<String, dynamic>;
                return {'limitReached': false, ...data};
            }
        } catch (_) {}
        return {'limitReached': false};
    }

    /// Passe un profil (dislike).
    static Future<void> pass(String targetId) async {
        try {
            final headers = await ApiService.authHeaders();
            await http.post(
                Uri.parse('${ApiService.baseUrl}/swipe/pass/$targetId'),
                headers: headers,
            );
        } catch (_) {}
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

    /// Retourne les profils qui ont liké l'utilisateur courant (Nocturne/Abyssal).
    /// [forbidden] = true si le plan est insuffisant (403).
    static Future<({List<Map<String, dynamic>> profiles, bool forbidden})> getWhoLikedMe() async {
        try {
            final headers = await ApiService.authHeaders();
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/swipe/who-liked-me'),
                headers: headers,
            );
            if (res.statusCode == 200) {
                final list = (jsonDecode(res.body) as List).cast<Map<String, dynamic>>();
                return (profiles: list, forbidden: false);
            }
            if (res.statusCode == 403) return (profiles: <Map<String, dynamic>>[], forbidden: true);
        } catch (_) {}
        return (profiles: <Map<String, dynamic>>[], forbidden: false);
    }
}

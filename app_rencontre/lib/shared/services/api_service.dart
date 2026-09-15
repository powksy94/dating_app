import 'dart:convert';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
    static const String _prodBaseUrl = 'https://datingappbackend-production-a9e3.up.railway.app/api';

    // A release build always points to prod, with no possible exception.
    // In debug (flutter run), defaults to the Android emulator's address
    // for the host (10.0.2.2); to test on a real phone on the same
    // network, pass the dev machine's local IP:
    //   flutter run --dart-define=API_BASE_URL=http://<local-ip>:3000/api
    static const String baseUrl = kReleaseMode
        ? _prodBaseUrl
        : String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:3000/api');

    // ── Token access ─────────────────────────────────────────────────────────────

    static Future<String?> getToken() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('jwt_token');
    }

    static Future<void> saveToken(String token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
    }

    static Future<String?> getRefreshToken() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('refresh_token');
    }

    static Future<void> saveRefreshToken(String token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh_token', token);
    }

    static Future<void> clearToken() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('jwt_token');
        await prefs.remove('refresh_token');
    }

    static Future<void> saveUserId(String userId) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', userId);
    }

    static Future<String?> getUserId() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('user_id');
    }

    // ── JWT helpers ───────────────────────────────────────────────────────────────

    static bool _isTokenExpired(String token) {
        try {
            final parts = token.split('.');
            if (parts.length != 3) return true;
            final payload = jsonDecode(
                utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
            final exp = payload['exp'] as int?;
            if (exp == null) return true;
            return DateTime.fromMillisecondsSinceEpoch(exp * 1000)
                .isBefore(DateTime.now().add(const Duration(minutes: 5)));
        } catch (_) {
            return true;
        }
    }

    // ── Refresh ───────────────────────────────────────────────────────────────────

    // The refresh token is single-use on the backend side (rotated on each call):
    // if two concurrent calls refresh at the same time, the second one arrives
    // with a token already invalidated by the first and wipes the session by mistake.
    // So we merge concurrent calls into a single in-flight refresh.
    static Future<bool>? _refreshInFlight;

    static Future<bool> refreshAccessToken() {
        return _refreshInFlight ??=
            _doRefresh().whenComplete(() => _refreshInFlight = null);
    }

    static Future<bool> _doRefresh() async {
        final refreshToken = await getRefreshToken();
        if (refreshToken == null) return false;
        try {
            final res = await http.post(
                Uri.parse('$baseUrl/auth/refresh'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'refreshToken': refreshToken}),
            );
            if (res.statusCode == 200) {
                final data = jsonDecode(res.body);
                await saveToken(data['token'] as String);
                await saveRefreshToken(data['refreshToken'] as String);
                return true;
            }
        } catch (_) {}
        return false;
    }

    // ── Headers (with transparent auto-refresh) ───────────────────────────────────

    static Future<Map<String, String>> authHeaders() async {
        var token = await getToken();
        if (token != null && _isTokenExpired(token)) {
            final refreshed = await refreshAccessToken();
            token = refreshed ? await getToken() : null;
            if (!refreshed) await clearToken();
        }
        return {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
        };
    }
}

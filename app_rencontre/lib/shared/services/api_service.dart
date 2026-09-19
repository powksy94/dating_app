import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Outcome of a token refresh. Only [rejected] means the session is over:
/// [unreachable] (offline, timeout, server error) says nothing about the token.
enum _RefreshResult { renewed, rejected, unreachable }

class ApiService {
    static const String _prodBaseUrl = 'https://datingappbackend-production-a9e3.up.railway.app/api';
    static const String _debugUrlOverride = String.fromEnvironment('API_BASE_URL');

    // A release build always points to prod, with no possible exception.
    // In debug (flutter run), defaults to the local backend: the iOS
    // Simulator can reach the host machine via `localhost` directly, but the
    // Android emulator needs its special host-loopback alias (10.0.2.2)
    // instead. To test on a real phone on the same network, pass the dev
    // machine's local IP:
    //   flutter run --dart-define=API_BASE_URL=http://<local-ip>:3000/api
    static String get baseUrl {
        if (kReleaseMode) return _prodBaseUrl;
        if (_debugUrlOverride.isNotEmpty) return _debugUrlOverride;
        return Platform.isIOS ? 'http://localhost:3000/api' : 'http://10.0.2.2:3000/api';
    }

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
    static Future<_RefreshResult>? _refreshInFlight;

    static Future<_RefreshResult> _refresh() {
        return _refreshInFlight ??=
            _doRefresh().whenComplete(() => _refreshInFlight = null);
    }

    static Future<_RefreshResult> _doRefresh() async {
        final refreshToken = await getRefreshToken();
        if (refreshToken == null) return _RefreshResult.rejected;
        try {
            final res = await http.post(
                Uri.parse('$baseUrl/auth/refresh'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'refreshToken': refreshToken}),
            ).timeout(const Duration(seconds: 10));
            if (res.statusCode == 200) {
                final data = jsonDecode(res.body);
                await saveToken(data['token'] as String);
                await saveRefreshToken(data['refreshToken'] as String);
                return _RefreshResult.renewed;
            }
            // The backend answers 401 when the refresh token is invalid or expired.
            if (res.statusCode == 401) return _RefreshResult.rejected;
        } catch (_) {}
        // Offline, timeout or server error: the refresh token may still be valid.
        return _RefreshResult.unreachable;
    }

    // ── Headers (with transparent auto-refresh) ───────────────────────────────────

    static Future<Map<String, String>> authHeaders() async {
        var token = await getToken();
        if (token != null && _isTokenExpired(token)) {
            switch (await _refresh()) {
                case _RefreshResult.renewed:
                    token = await getToken();
                case _RefreshResult.rejected:
                    await clearToken();
                    token = null;
                case _RefreshResult.unreachable:
                    // Keep the session: the expired token is still sent (it may
                    // be valid for a few more minutes) and the next call retries.
                    break;
            }
        }
        return {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
        };
    }
}

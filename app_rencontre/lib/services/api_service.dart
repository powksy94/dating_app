import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
    static const String baseUrl = 'https://datingappbackend-production-a9e3.up.railway.app/api';

    static Future<String?> getToken() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('jwt_token');
    }

    static Future<void> saveToken(String token) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
    }

    static Future<void> clearToken() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('jwt_token');
    }

    static Future<void> saveUserId(String userId) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', userId);
    }

    static Future<String?> getUserId() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('user_id');
    }

    static Future<Map<String, String>> authHeaders() async {
        final token = await getToken();
        return {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
        };
    }
}
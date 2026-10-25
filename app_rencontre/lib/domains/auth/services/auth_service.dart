import 'dart:convert';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:http/http.dart' as http;
import 'package:nocturne/core/build_channel.dart';
import 'package:nocturne/shared/services/api_service.dart';
import 'package:nocturne/shared/services/notification_service.dart';

/// Core session lifecycle: register, login, logout, account deletion and
/// password change. See password_reset_service.dart, email_verification_service.dart
/// and founding_member_reward_service.dart for the other auth-adjacent features.
class AuthService {
  Future<String> register(String email, String password, String username) async {
    final headers = {'Content-Type': 'application/json'};
    try {
      // Missing/failed token: let the backend reject with its own message
      // rather than failing the request client-side.
      final token = await FirebaseAppCheck.instance.getToken();
      if (token != null) headers['X-Firebase-AppCheck'] = token;
    } catch (_) {}

    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/register'),
      headers: headers,
      body: jsonEncode({
        'email': email, 'password': password, 'username': username,
        'testBuild': kTestBuild,
      }),
    ).timeout(const Duration(seconds: 15));
    final data = jsonDecode(res.body);
    if (res.statusCode == 201) {
      await ApiService.saveToken(data['token']);
      await ApiService.saveRefreshToken(data['refreshToken']);
      await ApiService.saveUserId(data['userId']);
      NotificationService.registerToken();
      return data['userId'];
    }
    throw Exception(data['message']);
  }

  Future<String> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    ).timeout(const Duration(seconds: 15));
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      await ApiService.saveToken(data['token']);
      await ApiService.saveRefreshToken(data['refreshToken']);
      await ApiService.saveUserId(data['userId']);
      NotificationService.registerToken();
      return data['userId'];
    }
    throw Exception(data['message']);
  }

  /// Returns null on success, otherwise the error message ([unknownError] when
  /// the backend sent none).
  Future<String?> changePassword(
    String currentPassword,
    String newPassword, {
    required String unknownError,
  }) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/change-password'),
      headers: headers,
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );
    if (res.statusCode == 200) return null;
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }

  Future<void> logout() async {
    try {
      final headers = await ApiService.authHeaders();
      await http.post(Uri.parse('${ApiService.baseUrl}/auth/logout'), headers: headers);
    } catch (_) {}
    await ApiService.clearToken();
  }

  /// Returns null on success, otherwise the error message ([unknownError] when
  /// the backend sent none).
  Future<String?> deleteAccount({required String unknownError}) async {
    final headers = await ApiService.authHeaders();
    final res = await http.delete(
      Uri.parse('${ApiService.baseUrl}/auth/account'),
      headers: headers,
    );
    if (res.statusCode == 200) {
      await ApiService.clearToken();
      return null;
    }
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }

  Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}

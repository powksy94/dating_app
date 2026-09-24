import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/core/build_channel.dart';
import 'package:nocturne/shared/services/api_service.dart';
import 'package:nocturne/shared/services/notification_service.dart';

class AuthService {
  Future<String> register(String email, String password, String username) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
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

  /// 'pending' once the founding-member gift is owed, 'claimed' once the user
  /// has opened it, or null (no gift, or the account/backend is unreachable).
  Future<String?> getFoundingMemberReward() async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http
          .get(Uri.parse('${ApiService.baseUrl}/auth/me'), headers: headers)
          .timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) return null;
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data['foundingMemberReward'] as String?;
    } catch (_) {
      return null;
    }
  }

  /// True once RevenueCat has granted the gift and the server has recorded
  /// the reward as claimed. False on any failure: the reward stays 'pending'
  /// so the reveal can be retried on next launch.
  Future<bool> claimFoundingMemberReward() async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http
          .post(Uri.parse('${ApiService.baseUrl}/users/me/reward/claim'), headers: headers)
          .timeout(const Duration(seconds: 15));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}
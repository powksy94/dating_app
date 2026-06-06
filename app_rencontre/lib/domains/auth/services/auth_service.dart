import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

class AuthService {
  Future<String> register(String email, String password, String username) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'username': username}),
    );
    final data = jsonDecode(res.body);
    if (res.statusCode == 201) {
      await ApiService.saveToken(data['token']);
      await ApiService.saveUserId(data['userId']);
      return data['userId'];
    }
    throw Exception(data['message']);
  }

  Future<String> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      await ApiService.saveToken(data['token']);
      await ApiService.saveUserId(data['userId']);
      return data['userId'];
    }
    throw Exception(data['message']);
  }

  /// Retourne null si succès, sinon le message d'erreur
  Future<String?> changePassword(String currentPassword, String newPassword) async {
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
    return (data['message'] as String?) ?? 'Erreur inconnue';
  }

  Future<void> logout() async {
    await ApiService.clearToken();
  }

  Future<String?> deleteAccount() async {
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
    return (data['message'] as String?) ?? 'Erreur inconnue';
  }

  Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}
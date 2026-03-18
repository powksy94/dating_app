import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

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
      return data['userId'];
    }
    throw Exception(data['message']);
  }

  Future<void> logout() async {
    await ApiService.clearToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}
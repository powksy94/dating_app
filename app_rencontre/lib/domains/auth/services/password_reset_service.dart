import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// The "forgot password" flow: request a code, verify it, then consume it
/// for a new password. See forgot_password/ for the UI.
class PasswordResetService {
  /// Returns null on success, otherwise an error message ([unknownError] when
  /// the backend sent none). The backend answers the same way whether or not
  /// the account exists, so null here just means "request accepted".
  Future<String?> forgotPassword(String email, {required String unknownError}) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    ).timeout(const Duration(seconds: 15));
    if (res.statusCode == 202) return null;
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }

  /// Returns null if the code is valid, otherwise an error message
  /// ([unknownError] when the backend sent none). Doesn't consume the code —
  /// resetPassword re-checks and consumes it for real.
  Future<String?> verifyResetCode(String email, String code, {required String unknownError}) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/verify-reset-code'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code}),
    ).timeout(const Duration(seconds: 15));
    if (res.statusCode == 200) return null;
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }

  /// Returns null on success, otherwise an error message ([unknownError] when
  /// the backend sent none).
  Future<String?> resetPassword(
    String email,
    String code,
    String newPassword, {
    required String unknownError,
  }) async {
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code, 'newPassword': newPassword}),
    ).timeout(const Duration(seconds: 15));
    if (res.statusCode == 200) return null;
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }
}

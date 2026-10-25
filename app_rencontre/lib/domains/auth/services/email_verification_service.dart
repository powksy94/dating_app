import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// The mandatory email-verification gate inserted right after registration
/// (see step_verify_email.dart in the register flow).
class EmailVerificationService {
  /// Returns null on success, otherwise an error message ([unknownError] when
  /// the backend sent none).
  Future<String?> verifyEmail(String code, {required String unknownError}) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/verify-email'),
      headers: headers,
      body: jsonEncode({'code': code}),
    ).timeout(const Duration(seconds: 15));
    if (res.statusCode == 200) return null;
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }

  /// True if the account's email is verified, OR if this can't be determined
  /// right now (unreachable backend, timeout) — fails open, since this is a
  /// UX guard against showing Home for an account with no saved profile, not
  /// a security boundary, and locking a legit user out over a network blip
  /// would be worse than letting them through.
  Future<bool> isEmailVerified() async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http
          .get(Uri.parse('${ApiService.baseUrl}/auth/me'), headers: headers)
          .timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) return true;
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return (data['emailVerified'] as bool?) ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Returns null on success, otherwise an error message ([unknownError] when
  /// the backend sent none).
  Future<String?> resendVerificationCode({required String unknownError}) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/auth/resend-verification-code'),
      headers: headers,
    ).timeout(const Duration(seconds: 15));
    if (res.statusCode == 202) return null;
    final data = jsonDecode(res.body);
    return (data['message'] as String?) ?? unknownError;
  }
}

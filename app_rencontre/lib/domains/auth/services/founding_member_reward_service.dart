import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// The founding-member launch gift (first 50 real accounts), claimed via
/// RevenueCat from home_page.dart.
class FoundingMemberRewardService {
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
}

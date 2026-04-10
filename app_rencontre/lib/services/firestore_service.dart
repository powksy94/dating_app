import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/alternative_profile.dart';
import '../models/liked_profile.dart';
import 'api_service.dart';

class FirestoreService {
  Future<AlternativeProfile?> getProfile(String uid) async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/profile/$uid'),
      headers: headers,
    );
    if (res.statusCode == 200) {
      return AlternativeProfile.fromJson(jsonDecode(res.body));
    }
    return null;
  }

  Future<AlternativeProfile?> getMyProfile() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/profile/me'),
      headers: headers,
    );
    if (res.statusCode == 200) {
      return AlternativeProfile.fromJson(jsonDecode(res.body));
    }
    return null;
  }

  Future<void> saveProfile(Map<String, dynamic> data) async {
    final headers = await ApiService.authHeaders();
    await http.put(
      Uri.parse('${ApiService.baseUrl}/profile/me'),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  Future<List<AlternativeProfile>> fetchSwipeProfiles() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/swipe/feed'),
      headers: headers,
    );
    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => AlternativeProfile.fromJson(e)).toList();
    }
    return [];
  }

  /// Retourne le matchId si c'est un match, null sinon
  Future<String?> saveLike(String targetId) async {
    final headers = await ApiService.authHeaders();
    final res = await http.post(
      Uri.parse('${ApiService.baseUrl}/swipe/like/$targetId'),
      headers: headers,
    );
    final data = jsonDecode(res.body);
    if (data['match'] == true) return (data['matchId'] as String?) ?? '';
    return null;
  }

  Future<void> seedDemoLikes() async {
    final headers = await ApiService.authHeaders();
    await http.post(
      Uri.parse('${ApiService.baseUrl}/dev/seed-likes'),
      headers: headers,
    );
  }

  Future<List<LikedProfile>> getLikedProfiles() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/swipe/liked'),
      headers: headers,
    );
    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => LikedProfile.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> saveDisLike(String targetId) async {
    final headers = await ApiService.authHeaders();
    await http.post(
      Uri.parse('${ApiService.baseUrl}/swipe/dislike/$targetId'),
      headers: headers,
    );
  }
}

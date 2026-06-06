import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/shared/services/api_service.dart';

class ChatService {
  static Future<List<ChatMatch>> getMatches() async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/matches'),
      headers: headers,
    );
    if (res.statusCode != 200) throw Exception('Erreur chargement matches');
    final List data = jsonDecode(res.body);
    return data.map((e) => ChatMatch.fromJson(e)).toList();
  }

  static Future<List<Message>> getMessages(String matchId) async {
    final headers = await ApiService.authHeaders();
    final res = await http.get(
      Uri.parse('${ApiService.baseUrl}/chat/$matchId'),
      headers: headers,
    );
    if (res.statusCode != 200) throw Exception('Erreur chargement messages');
    final List data = jsonDecode(res.body);
    return data.map((e) => Message.fromJson(e)).toList();
  }

  static Future<void> sendMessage(String matchId, String text) async {
    final headers = await ApiService.authHeaders();
    await http.post(
      Uri.parse('${ApiService.baseUrl}/chat/$matchId'),
      headers: headers,
      body: jsonEncode({'text': text}),
    );
  }

  static Future<String?> uploadChatImage(String imagePath) async {
    final token = await ApiService.getToken();
    final req   = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/chat/upload/image'),
    )
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    final stream = await req.send();
    final body   = await stream.stream.bytesToString();
    if (stream.statusCode == 200) {
      return jsonDecode(body)['url'] as String?;
    }
    return null;
  }

  static Future<String?> uploadChatAudio(String audioPath) async {
    final token = await ApiService.getToken();
    final req   = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/chat/upload/audio'),
    )
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('audio', audioPath));

    final stream = await req.send();
    final body   = await stream.stream.bytesToString();
    if (stream.statusCode == 200) {
      return jsonDecode(body)['url'] as String?;
    }
    return null;
  }

  static Future<void> deleteForMe(String messageId) async {
    final headers = await ApiService.authHeaders();
    await http.delete(
      Uri.parse('${ApiService.baseUrl}/chat/messages/$messageId/me'),
      headers: headers,
    );
  }

  static Future<void> deleteForAll(String messageId) async {
    final headers = await ApiService.authHeaders();
    await http.delete(
      Uri.parse('${ApiService.baseUrl}/chat/messages/$messageId/all'),
      headers: headers,
    );
  }
}
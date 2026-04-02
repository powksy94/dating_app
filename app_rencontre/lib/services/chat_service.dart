import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_match.dart';
import '../models/message.dart';
import 'api_service.dart';

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
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import 'api_service.dart';

class ChatService {
    Future<List<Message>> getMessages(String matchId) async {
        final headers = await ApiService.authHeaders();
        final res = await http.get(
            Uri.parse('${ApiService.baseUrl}/chat/$matchId'),
            headers: headers,
        );
        if (res.statusCode == 200) {
            final List list = jsonDecode(res.body);
            return list.map((e) => Message.fromJson(e)).toList();
        }
        return [];
    }

    Future<void> sendMessage(String matchId, String text) async {
        final headers = await ApiService.authHeaders();
        await http.post(
        Uri.parse('${ApiService.baseUrl}/chat/$matchId'),
        headers: headers,
        body: jsonEncode({'text': text}),
        );
    }

}
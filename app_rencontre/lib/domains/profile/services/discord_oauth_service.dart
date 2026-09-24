import 'dart:convert';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// Discord requires this exact scheme for a mobile redirect, built from the
/// app's own Application ID (same value as its OAuth2 Client ID) — not an
/// arbitrary custom scheme. Must match DISCORD_REDIRECT_URI on the server
/// (discord.ts) and the scheme declared in AndroidManifest.xml.
const _kCallbackScheme = 'discord-1552285088606064660';

class DiscordConnectionStatus {
  final bool connected;
  final String? username;
  final String? avatarUrl;

  const DiscordConnectionStatus({required this.connected, this.username, this.avatarUrl});

  factory DiscordConnectionStatus.fromJson(Map<String, dynamic> json) => DiscordConnectionStatus(
        connected: json['connected'] as bool? ?? false,
        username:  json['username'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
      );
}

class DiscordOAuthService {
  static Future<DiscordConnectionStatus> status() async {
    final headers = await ApiService.authHeaders();
    final res = await http
        .get(Uri.parse('${ApiService.baseUrl}/oauth/discord'), headers: headers)
        .timeout(const Duration(seconds: 10));
    if (res.statusCode != 200) return const DiscordConnectionStatus(connected: false);
    return DiscordConnectionStatus.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  /// Runs the whole flow: opens Discord's consent screen in the system
  /// browser, waits for the redirect, then asks the server to finish it.
  /// Throws on any failure (server unavailable, user cancelled, Discord
  /// refused the code); the caller decides how to tell the user.
  static Future<DiscordConnectionStatus> connect() async {
    final headers = await ApiService.authHeaders();

    final startRes = await http
        .get(Uri.parse('${ApiService.baseUrl}/oauth/discord/start'), headers: headers)
        .timeout(const Duration(seconds: 10));
    if (startRes.statusCode != 200) throw Exception('Discord connection unavailable');
    final authorizeUrl = (jsonDecode(startRes.body) as Map<String, dynamic>)['authorizeUrl'] as String;

    final result = await FlutterWebAuth2.authenticate(
      url: authorizeUrl,
      callbackUrlScheme: _kCallbackScheme,
    );
    final redirect = Uri.parse(result);
    final code  = redirect.queryParameters['code'];
    final state = redirect.queryParameters['state'];
    if (code == null || state == null) throw Exception('Discord did not return an authorization code');

    final callbackRes = await http
        .post(
          Uri.parse('${ApiService.baseUrl}/oauth/discord/callback'),
          headers: headers,
          body: jsonEncode({'code': code, 'state': state}),
        )
        .timeout(const Duration(seconds: 10));
    if (callbackRes.statusCode != 200) throw Exception('Discord refused this connection attempt');
    return DiscordConnectionStatus.fromJson(jsonDecode(callbackRes.body) as Map<String, dynamic>);
  }

  static Future<void> disconnect() async {
    final headers = await ApiService.authHeaders();
    await http
        .delete(Uri.parse('${ApiService.baseUrl}/oauth/discord'), headers: headers)
        .timeout(const Duration(seconds: 10));
  }
}

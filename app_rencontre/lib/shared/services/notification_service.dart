import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Received in the background, Android shows the notification automatically
}

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;

  static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    // Permissions
    await _messaging.requestPermission(
      alert:    true,
      badge:    true,
      sound:    true,
    );

    // Background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // FCM token -> backend
    final token = await _messaging.getToken();
    // ignore: avoid_print
    print('🔑 FCM TOKEN: $token');
    if (token != null) await _saveToken(token);

    // Token renewed
    _messaging.onTokenRefresh.listen(_saveToken);

    // Notification received in foreground
    FirebaseMessaging.onMessage.listen((message) {
      // The socket already handles real-time messages, no action needed
    });

    // Tap on notification (app in background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(message, navigatorKey);
    });

    // Tap on notification (app closed)
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _handleNotificationTap(initial, navigatorKey);
    }
  }

  static Future<void> _saveToken(String token) async {
    final headers = await ApiService.authHeaders();
    await http.post(
      Uri.parse('${ApiService.baseUrl}/profile/fcm-token'),
      headers: headers,
      body: jsonEncode({'token': token}),
    );
  }

  static void _handleNotificationTap(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    final data    = message.data;
    final type    = data['type'];
    final matchId = data['matchId'];

    switch (type) {
      case 'message':
        if (matchId != null) {
          navigatorKey.currentState?.pushNamed(
            '/conversation',
            arguments: {'matchId': matchId},
          );
        }
      case 'match':
        navigatorKey.currentState?.pushReplacementNamed('/home');
      case 'elegie':
        navigatorKey.currentState?.pushReplacementNamed('/home');
      case 'admin_auth':
        final sessionId = data['sessionId'];
        if (sessionId != null) {
          navigatorKey.currentState?.pushNamed(
            '/admin-auth',
            arguments: sessionId,
          );
        }
      case 'event_review':
        navigatorKey.currentState?.pushNamed('/event-review');
      case 'report_review':
        navigatorKey.currentState?.pushNamed('/report-review');
    }
  }
}

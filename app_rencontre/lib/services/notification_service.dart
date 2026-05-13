import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Reçu en background — Android affiche la notification automatiquement
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

    // Handler background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Token FCM → backend
    final token = await _messaging.getToken();
    // ignore: avoid_print
    print('🔑 FCM TOKEN: $token');
    if (token != null) await _saveToken(token);

    // Token renouvelé
    _messaging.onTokenRefresh.listen(_saveToken);

    // Notification reçue en foreground
    FirebaseMessaging.onMessage.listen((message) {
      // Le socket gère déjà les messages en temps réel → pas d'action
    });

    // Tap sur notification (app en background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(message, navigatorKey);
    });

    // Tap sur notification (app fermée)
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
    }
  }
}

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/services/api_service.dart';
import 'package:nocturne/shared/services/connectivity_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Received in the background, Android shows the notification automatically
}

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;

  // False until the current FCM token has been accepted by the backend, so a
  // failed upload (offline, logged out) is retried when the connection returns.
  static bool _tokenSynced = false;

  static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    // Listeners first: they need no network, so a launch without connection
    // can no longer skip them (a notification tap would then open nothing).
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Notification received in foreground
    FirebaseMessaging.onMessage.listen((message) {
      // The socket already handles real-time messages, no action needed
    });

    // Tap on notification (app in background)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationTap(message, navigatorKey);
    });

    // Token renewed
    _messaging.onTokenRefresh.listen((token) async {
      _tokenSynced = await _uploadToken(token);
    });

    // Retry a failed token upload when the connection comes back
    ConnectivityService.reconnected.addListener(() {
      if (!_tokenSynced) registerToken();
    });

    try {
      await _messaging.requestPermission(
        alert:    true,
        badge:    true,
        sound:    true,
      );
    } catch (_) {}

    await registerToken();

    // Tap on notification (app closed)
    try {
      final initial = await _messaging.getInitialMessage();
      if (initial != null) {
        _handleNotificationTap(initial, navigatorKey);
      }
    } catch (_) {}
  }

  /// Sends this device's FCM token to the backend for the logged-in user.
  /// Safe to call at any time: it does nothing when logged out and never throws.
  /// Also called after login and registration, because the launch-time call
  /// runs before the user has a session.
  static Future<void> registerToken() async {
    try {
      if (await ApiService.getToken() == null) return;
      final token = await _messaging.getToken();
      if (token == null) return;
      if (kDebugMode) debugPrint('FCM token: $token');
      _tokenSynced = await _uploadToken(token);
    } catch (_) {
      _tokenSynced = false;
    }
  }

  /// Language the app is shown in: the device language when the app is
  /// translated into it, English otherwise (the same fallback as the UI). The
  /// backend uses it to write push notifications in the user's language.
  static String _appLanguage() {
    final device = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final supported = AppLocalizations.supportedLocales
        .any((locale) => locale.languageCode == device);
    return supported ? device : 'en';
  }

  static Future<bool> _uploadToken(String token) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/profile/fcm-token'),
        headers: headers,
        body: jsonEncode({'token': token, 'locale': _appLanguage()}),
      ).timeout(const Duration(seconds: 10));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
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

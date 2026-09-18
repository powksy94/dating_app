import 'dart:io' show HttpOverrides;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:nocturne/app.dart';
import 'package:nocturne/shared/services/app_http_overrides.dart';
import 'package:nocturne/shared/services/revenue_cat_service.dart';
import 'package:nocturne/shared/services/stripe_config.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// The backend reads the build number from the User-Agent to enforce a minimum app version.
Future<void> _announceAppVersion() async {
  try {
    final info = await PackageInfo.fromPlatform();
    HttpOverrides.global = AppHttpOverrides('Nocturne/${info.version}+${info.buildNumber}');
  } catch (_) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _announceAppVersion();
  await Firebase.initializeApp();
  await RevenueCatService.initialize();
  await StripeConfig.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App(navigatorKey: navigatorKey));
}

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Watches the device connection and signals when it comes back after a loss.
/// Screens listen to [reconnected] (see ReloadOnReconnect) to reload by themselves.
class ConnectivityService {
  /// Incremented each time the device goes from offline to online.
  static final ValueNotifier<int> reconnected = ValueNotifier(0);

  static bool _online = true;
  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static Future<void> init() async {
    if (_subscription != null) return;
    try {
      final connectivity = Connectivity();
      _online = _hasConnection(await connectivity.checkConnectivity());
      _subscription = connectivity.onConnectivityChanged.listen(_onChanged);
    } catch (_) {}
  }

  static void _onChanged(List<ConnectivityResult> results) {
    final online = _hasConnection(results);
    final wasOffline = !_online;
    _online = online;
    if (online && wasOffline) {
      // Give the network stack a moment (DNS, routes) before screens retry.
      Future.delayed(const Duration(seconds: 1), () => reconnected.value++);
    }
  }

  static bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}

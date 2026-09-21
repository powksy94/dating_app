import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Watches the device connection and signals when it comes back after a loss.
/// Screens listen to [reconnected] (see ReloadOnReconnect) to reload by
/// themselves, and [online] drives the app-wide offline banner (see
/// OfflineBanner) so a lost connection is visible on every screen at once.
class ConnectivityService {
  /// Incremented each time the device goes from offline to online.
  static final ValueNotifier<int> reconnected = ValueNotifier(0);

  /// Current connection state, kept in sync with the OS. Assumes online until
  /// the first check completes, so the banner doesn't flash at launch.
  static final ValueNotifier<bool> online = ValueNotifier(true);

  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static Future<void> init() async {
    if (_subscription != null) return;
    try {
      final connectivity = Connectivity();
      online.value = _hasConnection(await connectivity.checkConnectivity());
      _subscription = connectivity.onConnectivityChanged.listen(_onChanged);
    } catch (_) {}
  }

  static void _onChanged(List<ConnectivityResult> results) {
    final wasOffline = !online.value;
    online.value = _hasConnection(results);
    if (online.value && wasOffline) {
      // Give the network stack a moment (DNS, routes) before screens retry.
      Future.delayed(const Duration(seconds: 1), () => reconnected.value++);
    }
  }

  static bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}

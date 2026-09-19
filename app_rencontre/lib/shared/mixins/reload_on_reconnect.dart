import 'package:flutter/widgets.dart';
import 'package:nocturne/shared/services/connectivity_service.dart';

/// Reloads a screen by itself when the device gets its connection back,
/// so the user does not have to press "Retry" on every screen.
mixin ReloadOnReconnect<T extends StatefulWidget> on State<T> {
  /// True while the screen shows a load failure that a reload could fix.
  bool get needsReload;

  /// Runs the screen's own load again.
  void reloadAfterReconnect();

  @override
  void initState() {
    super.initState();
    ConnectivityService.reconnected.addListener(_onReconnected);
  }

  @override
  void dispose() {
    ConnectivityService.reconnected.removeListener(_onReconnected);
    super.dispose();
  }

  void _onReconnected() {
    if (mounted && needsReload) reloadAfterReconnect();
  }
}

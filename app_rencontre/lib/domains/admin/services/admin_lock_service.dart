import 'package:local_auth/local_auth.dart';

/// Gates access to the in-app admin screens (Signalements, Photos...) behind
/// a fingerprint check, on top of the regular mobile login — so a stolen or
/// guessed password alone isn't enough to reach them. Stays unlocked only for
/// the current foreground session: app.dart locks it again whenever the app
/// is backgrounded or closed, the same way Revolut re-locks its app.
class AdminLockService {
  static final _localAuth = LocalAuthentication();

  static bool unlocked = false;

  static void lock() => unlocked = false;

  /// True once the admin screens can be shown: either already unlocked this
  /// session, or the biometric check just succeeded.
  static Future<bool> ensureUnlocked(String localizedReason) async {
    if (unlocked) return true;
    try {
      final canCheck  = await _localAuth.canCheckBiometrics;
      final supported = await _localAuth.isDeviceSupported();
      if (!canCheck && !supported) return false;

      final authenticated = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(stickyAuth: true, biometricOnly: false),
      );
      unlocked = authenticated;
      return authenticated;
    } catch (_) {
      return false;
    }
  }
}

import 'package:in_app_update/in_app_update.dart';

class AppVersionService {
  // Play only reports updates for builds installed from the Play Store, so this
  // lets you preview the dialog in debug: --dart-define=FORCE_UPDATE_DIALOG=true
  static const _forceUpdateDialog = bool.fromEnvironment('FORCE_UPDATE_DIALOG');

  /// Asks Google Play whether a newer version is published for this install.
  /// Returns false on any failure: a broken check must never block users.
  static Future<bool> isUpdateAvailable() async {
    if (_forceUpdateDialog) return true;
    try {
      final info = await InAppUpdate.checkForUpdate();
      return info.updateAvailability == UpdateAvailability.updateAvailable;
    } catch (_) {
      return false;
    }
  }
}

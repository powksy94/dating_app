import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:nocturne/shared/services/api_service.dart';

class AppVersionService {
  /// Returns false on any failure: a broken check must never lock users out.
  static Future<bool> isUpdateRequired() async {
    try {
      final info = await PackageInfo.fromPlatform();
      final installedBuild = int.tryParse(info.buildNumber);
      if (installedBuild == null) return false;

      final res = await http
          .get(Uri.parse('${ApiService.baseUrl}/app/version'))
          .timeout(const Duration(seconds: 5));
      if (res.statusCode != 200) return false;

      final minBuild = (jsonDecode(res.body)['minBuild'] as num?)?.toInt() ?? 0;
      return installedBuild < minBuild;
    } catch (_) {
      return false;
    }
  }
}

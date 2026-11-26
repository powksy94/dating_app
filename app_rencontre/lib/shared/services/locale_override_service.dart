import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nocturne/shared/services/api_service.dart';

/// The user's explicit language choice from settings, overriding the device's
/// own language. Null means no override: the app follows the device language,
/// exactly like before this service existed.
class LocaleOverrideService {
    static final ValueNotifier<Locale?> locale = ValueNotifier(null);

    static Future<void> init() async {
        final prefs = await SharedPreferences.getInstance();
        final code = prefs.getString('locale_override');
        if (code != null) locale.value = _decode(code);
    }

    static Future<void> set(Locale? newLocale) async {
        final prefs = await SharedPreferences.getInstance();
        if (newLocale == null) {
            await prefs.remove('locale_override');
        } else {
            await prefs.setString('locale_override', newLocale.toString());
        }
        locale.value = newLocale;
        if (newLocale != null) _pushToBackend(newLocale.languageCode);
    }

    static Future<void> _pushToBackend(String languageCode) async {
      try {
        final headers = await ApiService.authHeaders();
        await http.patch(
          Uri.parse('${ApiService.baseUrl}/profile/locale'),
          headers: headers,
          body: jsonEncode({'locale': languageCode}), 
        ).timeout(const Duration(seconds: 10));
      } catch (_) {}
    }

    // Locale.toString() already gives "pt_BR" (language_COUNTRY), which is also
    // what we need to read back to tell pt-BR and pt-PT apart.
    static Locale _decode(String code) {
        final parts = code.split('_');
        return parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
    }
}
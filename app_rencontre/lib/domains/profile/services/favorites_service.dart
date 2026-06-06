import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _key = 'favorite_event_ids';

  static Future<Set<String>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.toSet() ?? {};
  }

  static Future<void> toggle(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final favs  = prefs.getStringList(_key)?.toSet() ?? {};
    if (favs.contains(eventId)) {
      favs.remove(eventId);
    } else {
      favs.add(eventId);
    }
    await prefs.setStringList(_key, favs.toList());
  }

  static Future<bool> isFavorite(String eventId) async {
    final favs = await getAll();
    return favs.contains(eventId);
  }
}

import 'package:nocturne/domains/discovery/models/search_filters.dart';
import 'package:nocturne/shared/services/firestore_service.dart';

class SearchFiltersService {
  /// Current filters, or null when the user has no profile yet.
  /// Throws when the profile cannot be fetched (offline, server error).
  static Future<SearchFilters?> load() async {
    final profile = await FirestoreService().getMyProfile();
    return profile == null ? null : SearchFilters.fromProfile(profile);
  }

  static Future<void> save(SearchFilters filters) =>
      FirestoreService().saveProfile(filters.toProfileJson());
}

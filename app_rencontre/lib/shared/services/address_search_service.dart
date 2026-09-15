import 'package:nocturne/shared/services/address_result.dart';
import 'package:nocturne/shared/services/french_address_service.dart';
import 'package:nocturne/shared/services/nominatim_service.dart';

/// Queries the French Adresse API first (more precise), and only falls
/// back to Nominatim (worldwide coverage) if it returns nothing, typically
/// for an address outside of France.
class AddressSearchService {
  static Future<List<AddressResult>> search(String query) async {
    final french = await FrenchAddressService.search(query);
    if (french.isNotEmpty) return french;
    return NominatimService.search(query);
  }
}

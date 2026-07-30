import 'package:nocturne/shared/services/address_result.dart';
import 'package:nocturne/shared/services/french_address_service.dart';
import 'package:nocturne/shared/services/nominatim_service.dart';

/// Interroge l'API Adresse française en priorité (plus précise), et ne
/// retombe sur Nominatim (couverture mondiale) que si elle ne renvoie rien
/// — typiquement une adresse hors de France.
class AddressSearchService {
  static Future<List<AddressResult>> search(String query) async {
    final french = await FrenchAddressService.search(query);
    if (french.isNotEmpty) return french;
    return NominatimService.search(query);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/game_tag.dart';

class RankService {
  final String? riotApiKey;
  final String? apexKey;
  final String? trackerKey;
  final String? bungieKey;

  RankService({this.riotApiKey, this.apexKey, this.trackerKey, this.bungieKey});

  Future<Map<String, dynamic>?> _getJson(Uri uri, {Map<String, String>? headers}) async {
    try {
      final res = await http.get(uri, headers: headers).timeout(const Duration(seconds: 12));
      if (res.statusCode == 200) return jsonDecode(res.body) as Map<String, dynamic>?;
      return null;
    } on SocketException {
      return null;
    } on Exception {
      return null;
    }
  }

  // --- Exemple Valorant (similaire aux autres jeux)
  Future<GameTag?> fetchValorant(String riotName, String riotTag, {String region = 'eu'}) async {
    if (riotApiKey == null) return null;
    try {
      final puuidUrl = Uri.parse(
        'https://europe.api.riotgames.com/riot/account/v1/accounts/by-riot-id/$riotName/$riotTag?api_key=$riotApiKey'
      );

      final puuidJson = await _getJson(puuidUrl);
      final puuid = puuidJson?['puuid'];
      if (puuid == null) return null;

      final mmrUrl = Uri.parse('https://$region.api.riotgames.com/val/ranked/v1/mmr/$region/$puuid?api_key=$riotApiKey');
      final mmrJson = await _getJson(mmrUrl);
      if (mmrJson == null) return null;

      final tier = mmrJson['currenttierpatched'] ?? 'Unranked';
      return GameTag(gameName: 'Valorant', rank: tier, raw: mmrJson);
    } catch (e) {
      return null;
    }
  }

  // --- Autres jeux similaires
  // fetchLeagueOfLegends, fetchApex, fetchOverwatch, fetchDestiny2, fetchCallOfDuty, fetchBattlefield
  // doivent être modifiés pour renvoyer GameTag au lieu de Map

  // --- Aggregateur
  Future<List<GameTag>> getAllRanks(Map<String, String> identifiers) async {
    final List<GameTag> gameTags = [];

    final v = identifiers.containsKey('riotName') && identifiers.containsKey('riotTag')
        ? await fetchValorant(identifiers['riotName']!, identifiers['riotTag']!, region: identifiers['riotRegion'] ?? 'eu')
        : null;
    if (v != null) gameTags.add(v);

    // Même principe pour LoL, Apex, Overwatch, Destiny, COD, Battlefield
    // ex :
    // final lol = await fetchLeagueOfLegends(identifiers['summonerName']!);
    // if (lol != null) gameTags.add(lol);

    return gameTags;
  }
}

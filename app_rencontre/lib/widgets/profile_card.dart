import 'package:flutter/material.dart';
import '../models/gamer_profile.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileCard extends StatelessWidget {
  final GamerProfile profile;

  const ProfileCard({super.key, required this.profile});

  // Mapping global des couleurs par rang
  static const Map<String, Color> globalRankColors = {
    "iron": Color(0xff6e6e6e),
    "bronze": Color(0xffcd7f32),
    "silver": Color(0xffc0c0c0),
    "gold": Color(0xffffd700),
    "platinum": Color(0xff4bb2ff),
    "diamond": Color(0xff7fffd4),
    "ascendant": Color(0xff7CFC00),
    "emerald": Color(0xff7CFC00),
    "immortal": Color(0xffc300ff),
    "radiant": Color(0xffff7b00),
    "challenger": Color(0xffff7b00),
    "apex predator": Color(0xffff7b00),
    "master": Color(0xffff7b00),
    "grandmaster": Color(0xffff7b00),
  };

  Color getRankColor(String rank) {
    final r = rank.toLowerCase();
    for (var key in globalRankColors.keys) {
      if (r.contains(key)) return globalRankColors[key]!;
    }
    return Colors.white;
  }

  IconData _gameIcon(String game) {
    switch (game.toLowerCase()) {
      case 'valorant': return Icons.flash_on;
      case 'leagueoflegends': return Icons.shield;
      case 'apex':
      case 'apexlegends': return Icons.change_circle;
      case 'overwatch':
      case 'overwatch2': return Icons.sports_motorsports;
      case 'destiny2': return Icons.auto_awesome;
      case 'callofduty': return Icons.military_tech;
      case 'battlefield': return Icons.explore;
      default: return Icons.videogame_asset;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameEntries = profile.gameRanks.entries.toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 520,
        child: Stack(
          children: [
            Positioned.fill(
              child: profile.avatarUrl.isNotEmpty
                  ? Image.network(profile.avatarUrl, fit: BoxFit.cover)
                  : Container(color: Colors.grey[800]),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (gameEntries.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: gameEntries.map((entry) {
                        final game = entry.key;
                        final rank = entry.value['rank'] ?? 'Unranked';
                        final color = getRankColor(rank);
                        final iconUrl = entry.value['iconUrl'] as String?;
                        final externalUrl = profile.externalProfiles[game.toLowerCase()];

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: color,
                            boxShadow: [BoxShadow(color: color.withOpacity(0.35), blurRadius: 8, spreadRadius: 1)],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (externalUrl != null)
                                  ? GestureDetector(
                                      onTap: () => launchUrlString(externalUrl),
                                      child: Image.network(
                                        iconUrl ?? '',
                                        width: 20,
                                        height: 20,
                                        errorBuilder: (_, __, ___) => Icon(_gameIcon(game), size: 20, color: Colors.black),
                                      ),
                                    )
                                  : (iconUrl != null && iconUrl.isNotEmpty
                                      ? Image.network(
                                          iconUrl,
                                          width: 20,
                                          height: 20,
                                          errorBuilder: (_, __, ___) => Icon(_gameIcon(game), size: 20, color: Colors.black),
                                        )
                                      : Icon(_gameIcon(game), size: 20, color: Colors.black)),
                              const SizedBox(width: 8),
                              Text(
                                "$game : $rank",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              if (externalUrl != null)
                                IconButton(
                                  icon: const Icon(Icons.link, color: Colors.blueAccent, size: 20),
                                  onPressed: () => launchUrlString(externalUrl),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    profile.bio,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

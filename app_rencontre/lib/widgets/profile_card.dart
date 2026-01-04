import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/gamer_profile.dart';

class ProfileCard extends StatelessWidget {
  final GamerProfile profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final gameEntries = profile.gameRanks.entries.toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 520,
        child: Stack(
          children: [
            _BackgroundImage(profile.avatarUrl),
            _DarkGradient(),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Username(profile.username),
                  const SizedBox(height: 10),

                  if (gameEntries.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: gameEntries.map((entry) {
                        final game = entry.key;
                        final data = entry.value;

                        return GameBadge(
                          game: game,
                          rank: data['rank'] ?? 'Unranked',
                          iconUrl: data['iconUrl'],
                          externalUrl:
                              profile.externalProfiles[game.toLowerCase()],
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 12),
                  _Bio(profile.bio),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ==========================
/// UI COMPONENTS
/// ==========================

class _BackgroundImage extends StatelessWidget {
  final String url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: url.isNotEmpty
          ? Image.network(url, fit: BoxFit.cover)
          : Container(color: Colors.grey[800]),
    );
  }
}

class _DarkGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              Colors.black.withOpacity(0.85),
              Colors.transparent
            ],
          ),
        ),
      ),
    );
  }
}

class _Username extends StatelessWidget {
  final String name;
  const _Username(this.name);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        shadows: [Shadow(blurRadius: 8, color: Colors.black)],
      ),
    );
  }
}

class _Bio extends StatelessWidget {
  final String bio;
  const _Bio(this.bio);

  @override
  Widget build(BuildContext context) {
    return Text(
      bio,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white.withOpacity(0.85)),
    );
  }
}

/// ==========================
/// GAME BADGE RÉUTILISABLE
/// ==========================

class GameBadge extends StatelessWidget {
  final String game;
  final String rank;
  final String? iconUrl;
  final String? externalUrl;

  const GameBadge({
    super.key,
    required this.game,
    required this.rank,
    this.iconUrl,
    this.externalUrl,
  });

  @override
  Widget build(BuildContext context) {
    final color = rankColor(rank);

    return GestureDetector(
      onTap: externalUrl != null ? () => launchUrlString(externalUrl!) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 8,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BadgeIcon(game: game, iconUrl: iconUrl),
            const SizedBox(width: 8),
            Text(
              "$game : $rank",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (externalUrl != null)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(Icons.link,
                    size: 16, color: Colors.blueAccent),
              ),
          ],
        ),
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final String game;
  final String? iconUrl;

  const _BadgeIcon({required this.game, this.iconUrl});

  @override
  Widget build(BuildContext context) {
    if (iconUrl != null && iconUrl!.isNotEmpty) {
      return Image.network(
        iconUrl!,
        width: 20,
        height: 20,
        errorBuilder: (_, __, ___) =>
            Icon(gameIcon(game), size: 20, color: Colors.black),
      );
    }
    return Icon(gameIcon(game), size: 20, color: Colors.black);
  }
}

/// ==========================
/// UTILITAIRES GÉNÉRIQUES
/// ==========================

Color rankColor(String rank) {
  final r = rank.toLowerCase();

  if (r.contains('iron') || r.contains('rookie')) return const Color(0xff6e6e6e);
  if (r.contains('bronze')) return const Color(0xffcd7f32);
  if (r.contains('silver')) return const Color(0xffc0c0c0);
  if (r.contains('gold')) return const Color(0xffffd700);
  if (r.contains('plat')) return const Color(0xff4bb2ff);
  if (r.contains('diamond')) return const Color(0xff7fffd4);
  if (r.contains('emerald') || r.contains('ascendant'))
    return const Color(0xff7CFC00);
  if (r.contains('master') || r.contains('immortal'))
    return const Color(0xffc300ff);
  if (r.contains('grandmaster') ||
      r.contains('radiant') ||
      r.contains('challenger') ||
      r.contains('predator'))
    return const Color(0xffff7b00);

  return Colors.white;
}

IconData gameIcon(String game) {
  switch (game.toLowerCase()) {
    case 'valorant':
      return Icons.flash_on;
    case 'leagueoflegends':
      return Icons.shield;
    case 'apex':
    case 'apexlegends':
      return Icons.change_circle;
    case 'overwatch':
    case 'overwatch2':
      return Icons.sports_motorsports;
    case 'destiny2':
      return Icons.auto_awesome;
    case 'callofduty':
      return Icons.military_tech;
    case 'battlefield':
      return Icons.explore;
    default:
      return Icons.videogame_asset;
  }
}

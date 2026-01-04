import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/gamer_profile.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  final GamerProfile profile;

  const ProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(profile.username),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileCard(profile: profile),
            const SizedBox(height: 20),

            _buildSection(
              "Bio",
              Text(
                profile.bio,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            _buildSection(
              "Jeux & profils externes",
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: profile.gameRanks.entries.map((entry) {
                  final game = entry.key;
                  final data = entry.value;
                  final rank = data['rank'] ?? 'N/A';
                  final iconUrl = data['iconUrl'] as String?;
                  final externalUrl =
                      profile.externalProfiles[game.toLowerCase()];

                  return _GameBadge(
                    game: game,
                    rank: rank,
                    iconUrl: iconUrl,
                    externalUrl: externalUrl,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(14),
          ),
          child: content,
        ),
      ],
    );
  }
}

/// ================================
/// BADGE DE JEU RÉUTILISABLE
/// ================================
class _GameBadge extends StatelessWidget {
  final String game;
  final String rank;
  final String? iconUrl;
  final String? externalUrl;

  const _GameBadge({
    required this.game,
    required this.rank,
    this.iconUrl,
    this.externalUrl,
  });

  @override
  Widget build(BuildContext context) {
    final color = _rankColor(rank);

    return GestureDetector(
      onTap: externalUrl != null ? () => launchUrlString(externalUrl!) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(width: 6),
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
                child: Icon(Icons.link, size: 16, color: Colors.blueAccent),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconUrl != null && iconUrl!.isNotEmpty) {
      return Image.network(
        iconUrl!,
        width: 24,
        height: 24,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.videogame_asset, color: Colors.black),
      );
    }
    return const Icon(Icons.videogame_asset, color: Colors.black);
  }
}

/// ================================
/// COULEURS DE RANG GÉNÉRIQUES
/// (TOUS JEUX)
/// ================================
Color _rankColor(String rank) {
  final r = rank.toLowerCase();

  if (r.contains('iron') || r.contains('rookie')) return const Color(0xFF6E6E6E);
  if (r.contains('bronze')) return const Color(0xFFCD7F32);
  if (r.contains('silver')) return const Color(0xFFC0C0C0);
  if (r.contains('gold')) return const Color(0xFFFFD700);
  if (r.contains('plat')) return const Color(0xFF4BB2FF);
  if (r.contains('diamond')) return const Color(0xFF7FFFD4);
  if (r.contains('emerald') || r.contains('ascendant'))
    return const Color(0xFF7CFC00);
  if (r.contains('master') || r.contains('immortal'))
    return const Color(0xFFC300FF);
  if (r.contains('grandmaster') ||
      r.contains('radiant') ||
      r.contains('challenger') ||
      r.contains('predator'))
    return const Color(0xFFFF7B00);

  return Colors.white;
}

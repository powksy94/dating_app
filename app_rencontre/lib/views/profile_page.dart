import 'package:flutter/material.dart';
import '../models/gamer_profile.dart';
import '../widgets/profile_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            _buildSection("Bio", Text(profile.bio, style: const TextStyle(color: Colors.white70, fontSize: 16))),
            const SizedBox(height: 20),
            _buildSection(
              "Jeux et profils externes",
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: profile.gameRanks.entries.map((entry) {
                  final game = entry.key;
                  final rank = entry.value['rank'] ?? 'N/A';
                  final iconUrl = entry.value['iconUrl'] as String?;
                  final color = ProfileCard.globalRankColors.entries.firstWhere(
                    (e) => rank.toLowerCase().contains(e.key),
                    orElse: () => const MapEntry('default', Colors.white),
                  ).value;
                  final externalUrl = profile.externalProfiles[game.toLowerCase()];

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (externalUrl != null)
                            ? GestureDetector(
                                onTap: () => launchUrlString(externalUrl),
                                child: Image.network(
                                  iconUrl ?? '',
                                  width: 24,
                                  height: 24,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.videogame_asset, size: 24, color: Colors.black),
                                ),
                              )
                            : (iconUrl != null && iconUrl.isNotEmpty
                                ? Image.network(iconUrl, width: 24, height: 24)
                                : const Icon(Icons.videogame_asset, size: 24, color: Colors.black)),
                        const SizedBox(width: 6),
                        Text("$game : $rank", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        if (externalUrl != null)
                          IconButton(
                            icon: const Icon(Icons.link, color: Colors.blueAccent),
                            onPressed: () => launchUrlString(externalUrl),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(14)), child: content),
        ],
      );
}

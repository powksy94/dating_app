import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/alternative_profile.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  final AlternativeProfile profile;
  const ProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(profile.username)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(profile: profile),
            const SizedBox(height: 20),

            _Section(
              title: 'Bio',
              child: Text(profile.bio,
                  style: const TextStyle(
                      color: Color(0xFFAA9AB5), fontSize: 16)),
            ),

            if (profile.musicGenres.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Genres musicaux',
                child: _TagWrap(profile.musicGenres,
                    color: const Color(0xFF4A0072)),
              ),
            ],

            if (profile.musicVibes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Ambiance',
                child: _TagWrap(profile.musicVibes,
                    color: const Color(0xFF003366)),
              ),
            ],

            if (profile.aesthetics.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Esthétique & culture',
                child: Wrap(
                  spacing: 8, runSpacing: 8,
                  children: profile.aesthetics
                      .map((a) => AestheticChip(label: a))
                      .toList(),
                ),
              ),
            ],

            if (profile.soundIntensity.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Intensité sonore',
                child: _TagWrap(profile.soundIntensity,
                    color: const Color(0xFF6B0000)),
              ),
            ],

            if (profile.musicEras.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Époque / scène',
                child: _TagWrap(profile.musicEras,
                    color: const Color(0xFF2E1B00)),
              ),
            ],

            if (profile.discoveryFormats.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Découverte musicale',
                child: _TagWrap(profile.discoveryFormats,
                    color: const Color(0xFF1A2E00)),
              ),
            ],

            if (profile.favoriteBands.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Artistes favoris',
                child: Text(profile.favoriteBands.join(' · '),
                    style: const TextStyle(color: Color(0xFFE8E0EE))),
              ),
            ],

            if (profile.upcomingEvents.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Événements à venir',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: profile.upcomingEvents
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(children: [
                              const Icon(Icons.event,
                                  size: 16, color: Color(0xFF7B00D4)),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(e,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Color(0xFFE8E0EE))),
                              ),
                            ]),
                          ))
                      .toList(),
                ),
              ),
            ],

            if (profile.socialLinks.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                title: 'Liens',
                child: Wrap(
                  spacing: 10, runSpacing: 8,
                  children: profile.socialLinks.entries
                      .map((e) => _SocialLink(platform: e.key, url: e.value))
                      .toList(),
                ),
              ),
            ],

            const SizedBox(height: 30),
          ],
        ),
      ),
      ),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xFF7B00D4),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0A1F),
            borderRadius: BorderRadius.circular(14),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _TagWrap extends StatelessWidget {
  final List<String> tags;
  final Color color;
  const _TagWrap(this.tags, {required this.color});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: tags.map((tag) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 0.8),
        ),
        child: Text(tag,
            style: const TextStyle(
                color: Colors.white, fontSize: 12)),
      )).toList(),
    );
  }
}

class _SocialLink extends StatelessWidget {
  final String platform;
  final String url;
  const _SocialLink({required this.platform, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF7B00D4), width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_platformIcon(platform),
                size: 16, color: const Color(0xFF7B00D4)),
            const SizedBox(width: 6),
            Text(platform,
                style: const TextStyle(
                    color: Color(0xFFE8E0EE), fontSize: 13)),
          ],
        ),
      ),
    );
  }

  IconData _platformIcon(String p) {
    switch (p.toLowerCase()) {
      case 'instagram': return Icons.camera_alt;
      case 'bandcamp':  return Icons.music_note;
      case 'lastfm':    return Icons.bar_chart;
      case 'tumblr':    return Icons.dashboard;
      default:          return Icons.link;
    }
  }
}

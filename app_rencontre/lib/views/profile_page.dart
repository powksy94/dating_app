import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/alternative_profile.dart';
import '../services/subscription_service.dart';
import '../widgets/profile/profile_card.dart';
import '../widgets/common/section_block.dart';

class ProfilePage extends StatefulWidget {
  final AlternativeProfile profile;
  const ProfilePage({super.key, required this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _photoLimit = 2;

  @override
  void initState() {
    super.initState();
    _loadLimit();
  }

  Future<void> _loadLimit() async {
    final plan = await SubscriptionService.getCachedPlan();
    if (mounted) setState(() => _photoLimit = SubscriptionService.photoLimit(plan));
  }

  void _openPhotoViewer(int startIndex) {
    final photos = widget.profile.photos;
    if (photos.isEmpty) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => _PhotoViewer(
          photos: photos,
          initialIndex: startIndex,
          limit: _photoLimit,
          onUnlock: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/subscription');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final allPhotos = profile.photos;

    return Scaffold(
      appBar: AppBar(title: Text(profile.username)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grande photo principale — tap ouvre la galerie
              GestureDetector(
                onTap: () => _openPhotoViewer(0),
                child: ProfileCard(profile: profile),
              ),
              const SizedBox(height: 20),

              // Bio
              SectionBlock(
                title: 'Bio',
                child: Text(profile.bio,
                    style: const TextStyle(
                        color: Color(0xFFAA9AB5), fontSize: 16)),
              ),

              if (profile.musicGenres.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
                  title: 'Genres musicaux',
                  child: _TagWrap(profile.musicGenres,
                      color: const Color(0xFF4A0072)),
                ),
              ],

              if (profile.musicVibes.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
                  title: 'Ambiance',
                  child: _TagWrap(profile.musicVibes,
                      color: const Color(0xFF003366)),
                ),
              ],

              if (profile.aesthetics.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
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
                SectionBlock(
                  title: 'Intensité sonore',
                  child: _TagWrap(profile.soundIntensity,
                      color: const Color(0xFF6B0000)),
                ),
              ],

              if (profile.musicEras.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
                  title: 'Époque / scène',
                  child: _TagWrap(profile.musicEras,
                      color: const Color(0xFF2E1B00)),
                ),
              ],

              if (profile.discoveryFormats.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
                  title: 'Découverte musicale',
                  child: _TagWrap(profile.discoveryFormats,
                      color: const Color(0xFF1A2E00)),
                ),
              ],

              if (profile.favoriteBands.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
                  title: 'Artistes favoris',
                  child: Text(profile.favoriteBands.join(' · '),
                      style: const TextStyle(color: Color(0xFFE8E0EE))),
                ),
              ],

              if (profile.upcomingEvents.isNotEmpty) ...[
                const SizedBox(height: 16),
                SectionBlock(
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
                SectionBlock(
                  title: 'Liens',
                  child: Wrap(
                    spacing: 10, runSpacing: 8,
                    children: profile.socialLinks.entries
                        .map((e) => _SocialLink(platform: e.key, url: e.value))
                        .toList(),
                  ),
                ),
              ],

              // Autres photos
              if (allPhotos.length > 1) ...[
                const SizedBox(height: 24),
                const Text(
                  'PHOTOS',
                  style: TextStyle(
                    color: Color(0xFF7B00D4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: allPhotos.length,
                  itemBuilder: (context, index) {
                    final locked = index >= _photoLimit;
                    return GestureDetector(
                      onTap: locked
                          ? () => Navigator.pushNamed(context, '/subscription')
                          : () => _openPhotoViewer(index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              allPhotos[index],
                              fit: BoxFit.cover,
                            ),
                            if (locked) ...[
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                child: Container(
                                    color: Colors.black.withValues(alpha: 0.35)),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.lock,
                                      color: Color(0xFF7B00D4), size: 28),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7B00D4),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'PREMIUM',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
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

// ─── Galerie fullscreen ───────────────────────────────────────────────────────

class _PhotoViewer extends StatefulWidget {
  final List<String> photos;
  final int initialIndex;
  final int limit;
  final VoidCallback onUnlock;

  const _PhotoViewer({
    required this.photos,
    required this.initialIndex,
    required this.limit,
    required this.onUnlock,
  });

  @override
  State<_PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<_PhotoViewer> {
  late final PageController _ctrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _ctrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: SafeArea(
            child: Center(
              child: GestureDetector(
                // absorbe le tap sur la carte pour ne pas fermer
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: 540,
                      child: Stack(
                        children: [
                          // Photos
                          PageView.builder(
                            controller: _ctrl,
                            itemCount: widget.photos.length,
                            onPageChanged: (i) =>
                                setState(() => _current = i),
                            itemBuilder: (context, index) {
                              final locked = index >= widget.limit;
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    widget.photos[index],
                                    fit: BoxFit.cover,
                                  ),
                                  if (locked) ...[
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 22, sigmaY: 22),
                                      child: Container(
                                          color: Colors.black.withValues(alpha: 0.35)),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.lock,
                                              color: Color(0xFF7B00D4),
                                              size: 40),
                                          const SizedBox(height: 12),
                                          ElevatedButton(
                                            onPressed: widget.onUnlock,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF7B00D4),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                                'Débloquer avec Premium'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),

                          // Points en bas
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.photos.length,
                                (i) {
                                  final isActive = i == _current;
                                  return AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    width: isActive ? 20 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? const Color(0xFF7B00D4)
                                          : Colors.white38,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────


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
          color: color.withValues(alpha: 0.5),
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

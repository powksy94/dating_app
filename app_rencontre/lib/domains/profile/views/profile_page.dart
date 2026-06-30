import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/subscription/services/subscription_service.dart';
import 'package:nocturne/domains/profile/widgets/profile_card.dart';
import 'package:nocturne/domains/profile/widgets/profile_details_section.dart';
import 'package:nocturne/domains/profile/widgets/profile_photo_viewer.dart';
import 'package:nocturne/domains/profile/widgets/profile_inline_photo.dart';
import 'package:nocturne/shared/widgets/common/section_block.dart';

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

  List<String> get _allPhotos {
    final url = widget.profile.avatarUrl;
    final photos = widget.profile.photos;
    if (photos.isNotEmpty && photos.first == url) return photos;
    return [if (url.isNotEmpty) url, ...photos];
  }

  void _openPhotoViewer(int startIndex) {
    final photos = _allPhotos;
    if (photos.isEmpty) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => ProfilePhotoViewer(
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
    final l = AppLocalizations.of(context)!;
    final profile = widget.profile;
    final allPhotos = _allPhotos;

    return Scaffold(
      appBar: AppBar(title: Text(profile.username)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo 1 — principale
              GestureDetector(
                onTap: () => _openPhotoViewer(0),
                child: ProfileCard(profile: profile),
              ),
              const SizedBox(height: 20),

              // Bio
              if (profile.bio.isNotEmpty)
                SectionBlock(
                  title: l.profileSectionBio,
                  child: Text(
                    profile.bio,
                    style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
                  ),
                ),

              // Photo 2 — entre bio et détails
              if (allPhotos.length > 1) ...[
                const SizedBox(height: 20),
                ProfileInlinePhoto(
                  url: allPhotos[1],
                  locked: 1 >= _photoLimit,
                  onTap: () => _openPhotoViewer(1),
                  onLockedTap: () => Navigator.pushNamed(context, '/subscription'),
                ),
              ],
              const SizedBox(height: 20),

              // Détails (genres, vibes, aesthetics…) sans bio
              ProfileDetailsSection(profile: profile, showBio: false),

              // Photos 3 à 6 — verticalement après les détails
              for (int i = 2; i < allPhotos.length; i++) ...[
                const SizedBox(height: 20),
                ProfileInlinePhoto(
                  url: allPhotos[i],
                  locked: i >= _photoLimit,
                  onTap: () => _openPhotoViewer(i),
                  onLockedTap: () => Navigator.pushNamed(context, '/subscription'),
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

import 'package:flutter/material.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/subscription/services/subscription_service.dart';
import 'package:nocturne/domains/profile/widgets/profile_card.dart';
import 'package:nocturne/domains/profile/widgets/profile_details_section.dart';
import 'package:nocturne/domains/profile/widgets/profile_photo_grid.dart';
import 'package:nocturne/domains/profile/widgets/profile_photo_viewer.dart';

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

              ProfileDetailsSection(profile: profile),

              // Autres photos
              if (allPhotos.length > 1) ...[
                const SizedBox(height: 24),
                ProfilePhotoGrid(
                  photos: allPhotos,
                  photoLimit: _photoLimit,
                  onPhotoTap: _openPhotoViewer,
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

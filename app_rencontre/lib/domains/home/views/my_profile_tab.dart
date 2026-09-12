import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/profile/widgets/profile_card.dart';
import 'package:nocturne/domains/profile/widgets/profile_menu.dart';

class MyProfileTab extends StatefulWidget {
  const MyProfileTab({super.key});

  @override
  State<MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<MyProfileTab> {
  final _firestore = FirestoreService();
  AlternativeProfile? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    AlternativeProfile? profile;
    try {
      profile = await _firestore.getMyProfile();
    } catch (_) {}
    if (mounted) setState(() { _profile = profile; _loading = false; });
  }


  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const ProfileMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeMyProfileTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _openMenu(context),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: _profile == null ? _noProfile(context) : _profileContent(context),
      ),
    );
  }

  Widget _noProfile(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_add,
              size: 64, color: Color(0xFF7B00D4)),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.homeNoProfileTitle,
              style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 18)),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.homeNoProfileDescription,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(
              context, '/edit-profile',
              arguments: AlternativeProfile(
                id: '', uid: '',
                username: '', avatarUrl: '', bio: '',
              ),
            ).then((_) => _loadProfile()),
            icon: const Icon(Icons.edit),
            label: Text(AppLocalizations.of(context)!.homeBtnCreateProfile),
          ),
        ],
      ),
    );
  }

  Widget _profileContent(BuildContext context) {
    final p = _profile!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile', arguments: p),
            child: ProfileCard(profile: p),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/subscription'),
              icon: const Icon(Icons.auto_awesome, size: 18),
              label: Text(
                AppLocalizations.of(context)!.homePremiumBanner,
                style: const TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A0072),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF7B00D4)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/discovery/models/liked_profile.dart';
import 'package:nocturne/domains/discovery/widgets/like_profile_card.dart';

class MyLikesTab extends StatefulWidget {
  const MyLikesTab({super.key});

  @override
  State<MyLikesTab> createState() => _MyLikesTabState();
}

class _MyLikesTabState extends State<MyLikesTab> with AutomaticKeepAliveClientMixin {
  final _firestore = FirestoreService();
  List<LikedProfile> _profiles = [];
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final profiles = await _firestore.getLikedProfiles();
      if (mounted) setState(() { _profiles = profiles; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_profiles.isEmpty) {
      return const Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.favorite_border, size: 48, color: Color(0xFF7B00D4)),
          SizedBox(height: 12),
          Text('Aucun like pour l\'instant', style: TextStyle(color: Color(0xFFAA9AB5))),
        ]),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.72,
      ),
      itemCount: _profiles.length,
      itemBuilder: (_, i) => LikeProfileCard(profile: _profiles[i]),
    );
  }
}

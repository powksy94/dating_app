import 'package:flutter/material.dart';
import '../models/liked_profile.dart';
import '../services/firestore_service.dart';

class LikesHistoryPage extends StatefulWidget {
  const LikesHistoryPage({super.key});

  @override
  State<LikesHistoryPage> createState() => _LikesHistoryPageState();
}

class _LikesHistoryPageState extends State<LikesHistoryPage> {
  final _firestore = FirestoreService();
  List<LikedProfile> _profiles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

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
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'HISTORIQUE DES LIKES',
          style: TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _profiles.isEmpty
              ? const _EmptyState()
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: _profiles.length,
                  itemBuilder: (context, index) =>
                      _LikeCard(profile: _profiles[index]),
                ),
    );
  }
}

class _LikeCard extends StatelessWidget {
  final LikedProfile profile;
  const _LikeCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    final photo = profile.photos.isNotEmpty
        ? profile.photos.first
        : profile.avatarUrl;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1A0A1F),
        border: Border.all(
          color: profile.isMatch
              ? const Color(0xFF7B00D4)
              : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: profile.isMatch
            ? [BoxShadow(
                color: const Color(0xFF7B00D4).withValues(alpha: 0.3),
                blurRadius: 12,
              )]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo
            photo.isNotEmpty
                ? Image.network(photo, fit: BoxFit.cover)
                : Container(
                    color: const Color(0xFF2D1A3A),
                    child: const Icon(Icons.person,
                        color: Color(0xFF7B00D4), size: 48),
                  ),

            // Gradient bas
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xDD0D0010)],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),
            ),

            // Badge match
            if (profile.isMatch)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B00D4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'MATCH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

            // Infos bas
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    profile.age != null
                        ? '${profile.username}, ${profile.age}'
                        : profile.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Color(0xFF7B00D4)),
          SizedBox(height: 16),
          Text(
            'Aucun like pour l\'instant',
            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
          ),
        ],
      ),
    );
  }
}

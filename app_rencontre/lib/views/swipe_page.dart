import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/alternative_profile.dart';
import '../services/firestore_service.dart';
import '../widgets/swipe_card.dart';
import '../widgets/swipe_buttons.dart';
import '../widgets/match/match_overlay.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final _controller = CardSwiperController();
  final _firestore  = FirestoreService();

  List<AlternativeProfile> _profiles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadProfiles() async {
    try {
      await _firestore.seedDemoLikes();
      final profiles = await _firestore.fetchSwipeProfiles();
      if (mounted) setState(() { _profiles = profiles; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _onSwipe(int? prev, int? next, CardSwiperDirection direction) {
    if (prev == null) return;
    final profile = _profiles[prev];
    if (direction == CardSwiperDirection.right) {
      _firestore.saveLike(profile.uid).then((isMatch) {
        if (isMatch && mounted) _showMatchDialog(profile);
      });
    } else if (direction == CardSwiperDirection.left) {
      _firestore.saveDisLike(profile.uid);
    }
  }

  void _showMatchDialog(AlternativeProfile profile) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A0A1F),
        title: const Text('C\'est un match !',
            style: TextStyle(color: Color(0xFF7B00D4))),
        content: Text('Toi et ${profile.username} vous êtes maintenant connectés !',
            style: const TextStyle(color: Color(0xFFE8E0EE))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Super !'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('NOCTURNE')),
      body: _profiles.isEmpty
          ? const _EmptyState()
          : SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: CardSwiper(
                      controller: _controller,
                      cardsCount: _profiles.length,
                      onSwipe: _onSwipe,
                      numberOfCardsDisplayed: 2,
                      scale: 0.95,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      cardBuilder: (context, index) =>
                          SwipeCard(
                            profile: _profiles[index],
                            horizontalOffset: 0,
                            onTap: () => Navigator.pushNamed(
                              context, '/profile',
                              arguments: _profiles[index],
                            ),
                          ),
                    ),
                  ),
                  SwipeActionButtons(
                    onDislike: () => _controller.swipeLeft(),
                    onLike:    () => _controller.swipeRight(),
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
          Icon(Icons.nightlight, size: 64, color: Color(0xFF7B00D4)),
          SizedBox(height: 16),
          Text(
            'Aucun profil dans les parages...',
            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/alternative_profile.dart';
import '../services/firestore_service.dart';
import '../widgets/swipe/swipe_card.dart';
import '../widgets/swipe/swipe_buttons.dart';
import '../models/chat_match.dart';
import '../widgets/match/match_overlay.dart';
import '../widgets/elegie/elegie_bottom_sheet.dart';

class SwipePage extends StatefulWidget {
  final void Function(ChatMatch)? onNavigateToConversation;
  const SwipePage({super.key, this.onNavigateToConversation});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final _controller = CardSwiperController();
  final _firestore  = FirestoreService();

  List<AlternativeProfile> _profiles = [];
  bool _loading = true;
  int _currentIndex = 0;

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
    if (next != null) setState(() => _currentIndex = next);
    if (direction == CardSwiperDirection.right) {
      _firestore.saveLike(profile.uid).then((matchId) {
        if (matchId != null && mounted) _showMatchDialog(profile, matchId);
      });
    } else if (direction == CardSwiperDirection.left) {
      _firestore.saveDisLike(profile.uid);
    }
  }

  void _showMatchDialog(AlternativeProfile profile, String matchId) {
    final chatMatch = ChatMatch(
      matchId:  matchId,
      userId:   profile.uid,
      username: profile.username,
      avatarUrl: profile.avatarUrl,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => MatchOverlay(
          matchedProfile: profile,
          myAvatarUrl: null,
          onMessage: () => widget.onNavigateToConversation?.call(chatMatch),
        ),
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
                      numberOfCardsDisplayed: _profiles.length >= 2 ? 2 : 1,
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
                  // Bouton élégie
                  if (_profiles.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          if (_currentIndex < _profiles.length) {
                            showElegieBottomSheet(
                              context,
                              _profiles[_currentIndex],
                              widget.onNavigateToConversation,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A0A1F),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF7B00D4), width: 0.8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_note, color: Color(0xFF7B00D4), size: 18),
                              SizedBox(width: 6),
                              Text(
                                'Élégie',
                                style: TextStyle(
                                  color: Color(0xFF7B00D4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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

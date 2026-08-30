import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/discovery/services/swipe_empty_state_actions.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_body.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_empty_state.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_overlays.dart';
import 'package:nocturne/domains/discovery/services/swipe_service.dart';
import 'package:nocturne/domains/subscription/services/boost_service.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';

class SwipePage extends StatefulWidget {
  final void Function(ChatMatch)? onNavigateToConversation;
  final ValueNotifier<int>? refreshNotifier;
  const SwipePage({super.key, this.onNavigateToConversation, this.refreshNotifier});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  CardSwiperController _controller = CardSwiperController();
  final _firestore = FirestoreService();

  List<AlternativeProfile> _profiles = [];
  bool _loading    = true;
  int  _currentIndex = 0;
  bool _unlimited  = true;
  int  _remaining  = 0;
  int  _limit      = 30;
  int  _boostCredits = 0;
  bool _canRewind  = false;
  CardSwiperDirection?  _lastSwipeDirection;
  AlternativeProfile?   _lastSwipedProfile;
  int  _swiperKey  = 0;

  @override
  void initState() {
    super.initState();
    _loadAll();
    widget.refreshNotifier?.addListener(_loadStatus);
  }

  @override
  void dispose() {
    widget.refreshNotifier?.removeListener(_loadStatus);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async =>
      Future.wait([_loadProfiles(), _loadStatus()]);

  Future<void> _loadProfiles() async {
    try {
      final p = await _firestore.fetchSwipeProfiles();
      if (mounted) setState(() { _profiles = p; _loading = false; _currentIndex = 0; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadStatus() async {
    final swipe = await SwipeService.getStatus();
    final boost = await BoostService.getStatus();
    if (!mounted) return;
    setState(() {
      _unlimited    = swipe['unlimited'] as bool? ?? true;
      _remaining    = swipe['remaining'] as int?  ?? 0;
      _limit        = swipe['limit']     as int?  ?? 30;
      _boostCredits = boost['available'] as int?  ?? 0;
    });
  }

  Future<void> _onSwipe(int? prev, int? next, CardSwiperDirection dir) async {
    if (prev == null) return;
    final profile = _profiles[prev];
    if (next != null) setState(() => _currentIndex = next);
    _lastSwipeDirection = dir;
    _lastSwipedProfile  = profile;

    if (dir == CardSwiperDirection.right) {
      if (!_unlimited && _remaining <= 0) { SwipeOverlays.showSwipePaywall(context, _limit); return; }
      final res = await SwipeService.like(profile.uid);
      if (res['limitReached'] == true && mounted) { SwipeOverlays.showSwipePaywall(context, _limit); return; }
      if (!_unlimited) setState(() => _remaining = (_remaining - 1).clamp(0, _limit));
      setState(() => _canRewind = true);
      final matchId = res['matchId'] as String?;
      if (matchId != null && mounted) SwipeOverlays.showMatch(context, profile, matchId, widget.onNavigateToConversation);
    } else {
      SwipeService.pass(profile.uid);
      setState(() => _canRewind = true);
    }
  }

  Future<void> _onRewind() async {
    if (_lastSwipeDirection == CardSwiperDirection.right) {
      final result = await SwipeService.rewind();
      if (!mounted) return;
      if (result.forbidden) { SwipeOverlays.showRewindPaywall(context); return; }
      if (result.userId == null) return;
      if (!_unlimited) setState(() => _remaining = (_remaining + 1).clamp(0, _limit));
    }
    final rewound = _lastSwipedProfile;
    if (rewound == null) return;
    _controller = CardSwiperController();
    setState(() {
      _profiles = [rewound, ..._profiles.sublist(_currentIndex)];
      _currentIndex = 0;
      _canRewind = false;
      _lastSwipeDirection = null;
      _lastSwipedProfile  = null;
      _swiperKey++;
    });
  }

  Future<void> _onBoost() async {
    if (_boostCredits <= 0) { SwipeOverlays.showBoostPaywall(context); return; }
    final res = await BoostService.useBoost();
    if (res != null && mounted) {
      setState(() => _boostCredits = res['remaining'] as int? ?? 0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.discoveryBoostActivated),
        backgroundColor: const Color(0xFF4A0072),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final emptyStateActions = SwipeEmptyStateActions(
        context: context, onProfilesChanged: _loadProfiles);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.discoverySwipePageTitle)),
      body: _profiles.isEmpty
          ? SwipeEmptyState(
              onResetLikes: emptyStateActions.resetLikes,
              onEditFilters: emptyStateActions.editFilters,
              onWaitForMoon: emptyStateActions.waitForMoon,
            )
          : SwipeBody(
              key:                      ValueKey(_swiperKey),
              profiles:                 _profiles,
              controller:               _controller,
              onSwipe:                  _onSwipe,
              onRewind:                 _onRewind,
              onBoost:                  _onBoost,
              currentIndex:             _currentIndex,
              unlimited:                _unlimited,
              remaining:                _remaining,
              limit:                    _limit,
              boostCredits:             _boostCredits,
              canRewind:                _canRewind,
              onNavigateToConversation: widget.onNavigateToConversation,
            ),
    );
  }
}

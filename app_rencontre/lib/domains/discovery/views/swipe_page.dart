import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_body.dart';
import 'package:nocturne/domains/discovery/services/swipe_service.dart';
import 'package:nocturne/domains/subscription/services/boost_service.dart';
import 'package:nocturne/domains/subscription/widgets/paywall_sheet.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/match/widgets/match_overlay.dart';

class SwipePage extends StatefulWidget {
  final void Function(ChatMatch)? onNavigateToConversation;
  final ValueNotifier<int>? refreshNotifier;
  const SwipePage({super.key, this.onNavigateToConversation, this.refreshNotifier});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final _controller = CardSwiperController();
  final _firestore  = FirestoreService();

  List<AlternativeProfile> _profiles = [];
  bool _loading     = true;
  int  _currentIndex = 0;
  bool _unlimited   = true;
  int  _remaining   = 0;
  int  _limit       = 30;
  int  _boostCredits = 0;
  bool _canRewind   = false;

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

    if (dir == CardSwiperDirection.right) {
      if (!_unlimited && _remaining <= 0) { _showPaywall(); return; }
      final res = await SwipeService.like(profile.uid);
      if (res['limitReached'] == true && mounted) { _showPaywall(); return; }
      if (!_unlimited) setState(() => _remaining = (_remaining - 1).clamp(0, _limit));
      setState(() => _canRewind = true);
      final matchId = res['matchId'] as String?;
      if (matchId != null && mounted) _showMatch(profile, matchId);
    } else {
      SwipeService.pass(profile.uid);
    }
  }

  Future<void> _onRewind() async {
    final result = await SwipeService.rewind();
    if (!mounted) return;
    if (result.forbidden) {
      final l = AppLocalizations.of(context)!;
      PaywallSheet.show(
        context,
        title: l.discoveryRewindTitle,
        description: l.discoveryRewindBody,
        requiredPlan: 'nocturne',
        icon: Icons.replay,
      );
      return;
    }
    if (result.userId != null) {
      setState(() {
        _canRewind = false;
        if (!_unlimited) _remaining = (_remaining + 1).clamp(0, _limit);
      });
      _loadProfiles();
    }
  }

  Future<void> _onBoost() async {
    final res = await BoostService.useBoost();
    if (res != null && mounted) {
      setState(() => _boostCredits = res['remaining'] as int? ?? 0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.discoveryBoostActivated),
        backgroundColor: const Color(0xFF4A0072),
      ));
    }
  }

  void _showPaywall() {
    final l = AppLocalizations.of(context)!;
    PaywallSheet.show(
      context,
      title: l.discoverySwipeLimitTitle,
      description: l.discoverySwipeLimitBody(_limit),
      requiredPlan: 'nocturne',
      icon: Icons.swap_horiz,
    );
  }

  void _showMatch(AlternativeProfile profile, String matchId) {
    final match = ChatMatch(matchId: matchId, userId: profile.uid, username: profile.username, avatarUrl: profile.avatarUrl);
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => MatchOverlay(
        matchedProfile: profile, myAvatarUrl: null,
        onMessage: () => widget.onNavigateToConversation?.call(match),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.discoverySwipePageTitle)),
      body: _profiles.isEmpty
          ? const _EmptyState()
          : SwipeBody(
              profiles:               _profiles,
              controller:             _controller,
              onSwipe:                _onSwipe,
              onRewind:               _onRewind,
              onBoost:                _onBoost,
              currentIndex:           _currentIndex,
              unlimited:              _unlimited,
              remaining:              _remaining,
              limit:                  _limit,
              boostCredits:           _boostCredits,
              canRewind:              _canRewind,
              onNavigateToConversation: widget.onNavigateToConversation,
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.nightlight, size: 64, color: Color(0xFF7B00D4)),
      const SizedBox(height: 16),
      Text(AppLocalizations.of(context)!.discoveryEmptyProfiles, style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16)),
    ]),
  );
}

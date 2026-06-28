import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_card.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_buttons.dart';
import 'package:nocturne/domains/discovery/widgets/swipe_counter_bar.dart';
import 'package:nocturne/domains/elegie/widgets/elegie_bottom_sheet.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';

class SwipeBody extends StatelessWidget {
  final List<AlternativeProfile> profiles;
  final CardSwiperController controller;
  final Future<void> Function(int?, int?, CardSwiperDirection) onSwipe;
  final VoidCallback onRewind;
  final VoidCallback onBoost;
  final int currentIndex;
  final bool unlimited;
  final int remaining;
  final int limit;
  final int boostCredits;
  final bool canRewind;
  final void Function(ChatMatch)? onNavigateToConversation;

  const SwipeBody({
    super.key,
    required this.profiles,
    required this.controller,
    required this.onSwipe,
    required this.onRewind,
    required this.onBoost,
    required this.currentIndex,
    required this.unlimited,
    required this.remaining,
    required this.limit,
    required this.boostCredits,
    required this.canRewind,
    this.onNavigateToConversation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          if (!unlimited)
            SwipeCounterBar(remaining: remaining, limit: limit),
          Expanded(
            child: CardSwiper(
              controller: controller,
              cardsCount: profiles.length,
              onSwipe: onSwipe,
              numberOfCardsDisplayed: profiles.length >= 2 ? 2 : 1,
              scale: 0.95,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              cardBuilder: (context, index) => SwipeCard(
                profile: profiles[index],
                horizontalOffset: 0,
                onTap: () => Navigator.pushNamed(context, '/profile', arguments: profiles[index]),
              ),
            ),
          ),
          _ElegieButton(
            onTap: currentIndex < profiles.length
                ? () => showElegieBottomSheet(context, profiles[currentIndex], onNavigateToConversation)
                : null,
          ),
          SwipeActionButtons(
            onDislike:    () => controller.swipeLeft(),
            onLike:       () => controller.swipeRight(),
            onRewind:     canRewind ? onRewind : null,
            onBoost:      onBoost,
            boostCredits: boostCredits,
          ),
        ],
      ),
    );
  }
}

class _ElegieButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _ElegieButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0A1F),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF7B00D4), width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.edit_note, color: Color(0xFF7B00D4), size: 18),
              const SizedBox(width: 6),
              Text(AppLocalizations.of(context)!.discoveryBtnElegie, style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/subscription/widgets/paywall_sheet.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/match/widgets/match_overlay.dart';

abstract final class SwipeOverlays {
  static void showSwipePaywall(BuildContext context, int limit) {
    final l = AppLocalizations.of(context)!;
    PaywallSheet.show(context,
      title: l.discoverySwipeLimitTitle,
      description: l.discoverySwipeLimitBody(limit),
      requiredPlan: 'nocturne',
      icon: Icons.swap_horiz,
    );
  }

  static void showRewindPaywall(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    PaywallSheet.show(context,
      title: l.discoveryRewindTitle,
      description: l.discoveryRewindBody,
      requiredPlan: 'nocturne',
      icon: Icons.replay,
    );
  }

  static void showBoostPaywall(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    PaywallSheet.show(context,
      title: l.discoveryBoostTitle,
      description: l.discoveryBoostBody,
      requiredPlan: 'nocturne',
      icon: Icons.bolt,
    );
  }

  static void showMatch(
    BuildContext context,
    AlternativeProfile profile,
    String matchId,
    void Function(ChatMatch)? onNavigate,
  ) {
    final match = ChatMatch(
      matchId: matchId, userId: profile.uid,
      username: profile.username, avatarUrl: profile.avatarUrl,
    );
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => MatchOverlay(
        matchedProfile: profile, myAvatarUrl: null,
        onMessage: () => onNavigate?.call(match),
      ),
    ));
  }
}

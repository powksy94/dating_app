import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/subscription/models/plan_limits.dart';

export 'package:nocturne/domains/subscription/models/subscription_period.dart';
export 'package:nocturne/domains/subscription/models/plan_limits.dart';

class SubscriptionFeature {
    final String label;
    final bool included;
    const SubscriptionFeature(this.label, this.included);
}

class SubscriptionPlan {
    final String id;
    final String name;
    final Color color;
    final Color accentColor;
    final IconData icon;
    final String? badge;
    final bool isFree;
    final List<SubscriptionFeature> features;
    final PlanLimits limits;
    final String freeLabel;

    // Paid plans carry no price here: the localized price always comes from
    // the store (see storePriceFor), so it can never drift from what Play charges.
    const SubscriptionPlan({
        required this.id,
        required this.name,
        required this.color,
        required this.accentColor,
        required this.icon,
        this.badge,
        this.isFree = false,
        required this.features,
        required this.limits,
        required this.freeLabel,
    });
}

/// Plan identifiers, in display order (stable, language-independent).
const kSubscriptionPlanIds = ['ombre', 'nocturne', 'abyssal'];

List<SubscriptionPlan> subscriptionPlans(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return [
        SubscriptionPlan(
            id: 'ombre', name: l.subscriptionPlanOmbre, color: const Color(0xFF2D2D2D), accentColor: const Color(0xFFAA9AB5),
            icon: Icons.nightlight_outlined, isFree: true,
            limits: kOmbreLimits,
            freeLabel: l.subscriptionPriceFree,
            features: [
                SubscriptionFeature(l.featureOmbreSwipes, true),
                SubscriptionFeature(l.featureOmbreElegies, true),
                SubscriptionFeature(l.featureOmbreEvents, true),
                SubscriptionFeature(l.featureOmbrePhotos, true),
                SubscriptionFeature(l.featureWhoLikedMe, false),
                SubscriptionFeature(l.featureWhoVisited, false),
                SubscriptionFeature(l.featureRewind, false),
                SubscriptionFeature(l.featureBoostGeneric, false),
            ],
        ),
        SubscriptionPlan(
            id: 'nocturne', name: l.subscriptionPlanNocturne, color: const Color(0xFF4A0072), accentColor: const Color(0xFF7B00D4),
            icon: Icons.nightlight, badge: l.subscriptionBadgePopular,
            limits: kNocturneLimits,
            freeLabel: l.subscriptionPriceFree,
            features: [
                SubscriptionFeature(l.featureUnlimitedSwipe, true),
                SubscriptionFeature(l.featureNocturneElegies, true),
                SubscriptionFeature(l.featureNocturneEvents, true),
                SubscriptionFeature(l.featurePhotos6, true),
                SubscriptionFeature(l.featureWhoLikedMe, true),
                SubscriptionFeature(l.featureWhoVisited, true),
                SubscriptionFeature(l.featureRewind, true),
                SubscriptionFeature(l.featureBoostMonthly, true),
            ],
        ),
        SubscriptionPlan(
            id: 'abyssal', name: l.subscriptionPlanAbyssal, color: const Color(0xFF1A0A1F), accentColor: const Color(0xFFD400FF),
            icon: Icons.auto_awesome,
            limits: kAbyssalLimits,
            freeLabel: l.subscriptionPriceFree,
            features: [
                SubscriptionFeature(l.featureUnlimitedSwipe, true),
                SubscriptionFeature(l.featureUnlimitedElegies, true),
                SubscriptionFeature(l.featureUnlimitedEvents, true),
                SubscriptionFeature(l.featurePhotos6, true),
                SubscriptionFeature(l.featureWhoLikedMe, true),
                SubscriptionFeature(l.featureWhoVisited, true),
                SubscriptionFeature(l.featureRewind, true),
                SubscriptionFeature(l.featureBoostWeekly, true),
            ],
        ),
    ];
}

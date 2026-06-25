import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/subscription/models/subscription_period.dart';
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
    final String? weekPrice;
    final String? monthPrice;
    final String? monthPriceOriginal;
    final String? yearPrice;
    final String? yearPriceOriginal;
    final List<SubscriptionFeature> features;
    final PlanLimits limits;
    final String freeLabel;

    const SubscriptionPlan({
        required this.id,
        required this.name,
        required this.color,
        required this.accentColor,
        required this.icon,
        this.badge,
        required this.weekPrice,
        required this.monthPrice,
        this.monthPriceOriginal,
        required this.yearPrice,
        this.yearPriceOriginal,
        required this.features,
        required this.limits,
        required this.freeLabel,
    });

    String priceFor(SubscriptionPeriod period) {
        if (weekPrice == null) return freeLabel;
        switch (period) {
            case SubscriptionPeriod.week:  return weekPrice!;
            case SubscriptionPeriod.month: return monthPrice!;
            case SubscriptionPeriod.year:  return yearPrice!;
        }
    }

    String? originalPriceFor(SubscriptionPeriod period) {
        switch (period) {
            case SubscriptionPeriod.week:  return null;
            case SubscriptionPeriod.month: return monthPriceOriginal;
            case SubscriptionPeriod.year:  return yearPriceOriginal;
        }
    }

    bool get isFree => weekPrice == null;
}

// ─── Prix ─────────────────────────────────────────────────────────────────────
const kNocturneWeekPrice          = '6,99 €';
const kNocturneMonthPrice         = '27,24 €';
const kNocturneMonthPriceOriginal = '30,26 €';
const kNocturneYearPrice          = '294,19 €';
const kNocturneYearPriceOriginal  = '363,48 €';

const kAbyssalWeekPrice           = '9,99 €';
const kAbyssalMonthPrice          = '38,93 €';
const kAbyssalMonthPriceOriginal  = '43,26 €';
const kAbyssalYearPrice           = '420,44 €';
const kAbyssalYearPriceOriginal   = '519,07 €';
// ──────────────────────────────────────────────────────────────────────────────

/// Identifiants des plans, dans l'ordre d'affichage (stable, indépendant de la langue).
const kSubscriptionPlanIds = ['ombre', 'nocturne', 'abyssal'];

List<SubscriptionPlan> subscriptionPlans(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return [
        SubscriptionPlan(
            id: 'ombre', name: l.subscriptionPlanOmbre, color: const Color(0xFF2D2D2D), accentColor: const Color(0xFFAA9AB5),
            icon: Icons.nightlight_outlined, weekPrice: null, monthPrice: null, yearPrice: null,
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
            weekPrice: kNocturneWeekPrice, monthPrice: kNocturneMonthPrice,
            monthPriceOriginal: kNocturneMonthPriceOriginal,
            yearPrice: kNocturneYearPrice, yearPriceOriginal: kNocturneYearPriceOriginal,
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
            weekPrice: kAbyssalWeekPrice, monthPrice: kAbyssalMonthPrice,
            monthPriceOriginal: kAbyssalMonthPriceOriginal,
            yearPrice: kAbyssalYearPrice, yearPriceOriginal: kAbyssalYearPriceOriginal,
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

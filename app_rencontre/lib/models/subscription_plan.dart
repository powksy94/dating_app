import 'package:flutter/material.dart';
import 'subscription_period.dart';
import 'plan_limits.dart';

class SubscriptionFeature {
    final String label;
    final bool included;
    const SubscriptionFeature(this.label, this.included);
}

class SubscriptionPlan {
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

    const SubscriptionPlan({
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
    });

    String priceFor(SubscriptionPeriod period) {
        if (weekPrice == null) return 'Gratuit';
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

const kSubscriptionPlans = [
    SubscriptionPlan(
        name: 'Ombre', color: Color(0xFF2D2D2D), accentColor: Color(0xFFAA9AB5),
        icon: Icons.nightlight_outlined, weekPrice: null, monthPrice: null, yearPrice: null,
        limits: kOmbreLimits,
        features: [
            SubscriptionFeature('30 swipes par jour', true),
            SubscriptionFeature('3 élégies par mois', true),
            SubscriptionFeature('2 événements par mois', true),
            SubscriptionFeature('2 photos par profil', true),
            SubscriptionFeature('Voir qui t\'a liké', false),
            SubscriptionFeature('Qui a visité ton profil', false),
            SubscriptionFeature('Rewind (annuler un swipe)', false),
            SubscriptionFeature('Boost de profil', false),
        ],
    ),
    SubscriptionPlan(
        name: 'Nocturne', color: Color(0xFF4A0072), accentColor: Color(0xFF7B00D4),
        icon: Icons.nightlight, badge: 'POPULAIRE',
        weekPrice: kNocturneWeekPrice, monthPrice: kNocturneMonthPrice,
        monthPriceOriginal: kNocturneMonthPriceOriginal,
        yearPrice: kNocturneYearPrice, yearPriceOriginal: kNocturneYearPriceOriginal,
        limits: kNocturneLimits,
        features: [
            SubscriptionFeature('Swipe illimité', true),
            SubscriptionFeature('15 élégies par mois', true),
            SubscriptionFeature('4 événements par mois', true),
            SubscriptionFeature('6 photos par profil', true),
            SubscriptionFeature('Voir qui t\'a liké', true),
            SubscriptionFeature('Qui a visité ton profil', true),
            SubscriptionFeature('Rewind (annuler un swipe)', true),
            SubscriptionFeature('1 boost par mois', true),
        ],
    ),
    SubscriptionPlan(
        name: 'Abyssal', color: Color(0xFF1A0A1F), accentColor: Color(0xFFD400FF),
        icon: Icons.auto_awesome,
        weekPrice: kAbyssalWeekPrice, monthPrice: kAbyssalMonthPrice,
        monthPriceOriginal: kAbyssalMonthPriceOriginal,
        yearPrice: kAbyssalYearPrice, yearPriceOriginal: kAbyssalYearPriceOriginal,
        limits: kAbyssalLimits,
        features: [
            SubscriptionFeature('Swipe illimité', true),
            SubscriptionFeature('Élégies illimitées', true),
            SubscriptionFeature('Événements illimités', true),
            SubscriptionFeature('6 photos par profil', true),
            SubscriptionFeature('Voir qui t\'a liké', true),
            SubscriptionFeature('Qui a visité ton profil', true),
            SubscriptionFeature('Rewind (annuler un swipe)', true),
            SubscriptionFeature('1 boost par semaine', true),
        ],
    ),
];

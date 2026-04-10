import 'package:flutter/material.dart';

enum SubscriptionPeriod { week, month, year }

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

// ─── Prix centralisés ─────────────────────────────────────────────────────────
const kNocturneWeekPrice          = '6,99 €';
const kNocturneMonthPrice         = '27,24 €';
const kNocturneMonthPriceOriginal = '30,26 €'; // -10%
const kNocturneYearPrice          = '294,19 €';
const kNocturneYearPriceOriginal  = '363,48 €'; // -19%

const kAbyssalWeekPrice           = '9,99 €';
const kAbyssalMonthPrice          = '38,93 €';
const kAbyssalMonthPriceOriginal  = '43,26 €';  // -10%
const kAbyssalYearPrice           = '420,44 €';
const kAbyssalYearPriceOriginal   = '519,07 €'; // -19%
// ──────────────────────────────────────────────────────────────────────────────

const kSubscriptionPlans = [
    SubscriptionPlan(
        name: 'Ombre',
        color: Color(0xFF2D2D2D),
        accentColor: Color(0xFFAA9AB5),
        icon: Icons.nightlight_outlined,
        weekPrice: null,
        monthPrice: null,
        yearPrice: null,
        features: [
            SubscriptionFeature('30 swipes par jour', true),
            SubscriptionFeature('Voir les profils proches', true),
            SubscriptionFeature('2 photos par profil', true),
            SubscriptionFeature('Voir qui t\'a liké', false),
            SubscriptionFeature('Filtres avancés', false),
            SubscriptionFeature('Mode invisible', false),
            SubscriptionFeature('Boost de profil', false),
        ],
    ),
    SubscriptionPlan(
        name: 'Nocturne',
        color: Color(0xFF4A0072),
        accentColor: Color(0xFF7B00D4),
        icon: Icons.nightlight,
        badge: 'POPULAIRE',
        weekPrice: kNocturneWeekPrice,
        monthPrice: kNocturneMonthPrice,
        monthPriceOriginal: kNocturneMonthPriceOriginal,
        yearPrice: kNocturneYearPrice,
        yearPriceOriginal: kNocturneYearPriceOriginal,
        features: [
            SubscriptionFeature('Swipe illimité', true),
            SubscriptionFeature('Voir les profils proches', true),
            SubscriptionFeature('6 photos par profil', true),
            SubscriptionFeature('Voir qui t\'a liké', true),
            SubscriptionFeature('Filtres avancés', true),
            SubscriptionFeature('Mode invisible', true),
            SubscriptionFeature('Boost de profil', false),
        ],
    ),
    SubscriptionPlan(
        name: 'Abyssal',
        color: Color(0xFF1A0A1F),
        accentColor: Color(0xFFD400FF),
        icon: Icons.auto_awesome,
        weekPrice: kAbyssalWeekPrice,
        monthPrice: kAbyssalMonthPrice,
        monthPriceOriginal: kAbyssalMonthPriceOriginal,
        yearPrice: kAbyssalYearPrice,
        yearPriceOriginal: kAbyssalYearPriceOriginal,
        features: [
            SubscriptionFeature('Swipe illimité', true),
            SubscriptionFeature('Voir les profils proches', true),
            SubscriptionFeature('6 photos par profil', true),
            SubscriptionFeature('Voir qui t\'a liké', true),
            SubscriptionFeature('Filtres avancés', true),
            SubscriptionFeature('Mode invisible', true),
            SubscriptionFeature('1 boost/semaine', true),
        ],
    ),
];

String periodLabel(SubscriptionPeriod p) {
    switch (p) {
        case SubscriptionPeriod.week: return '/ semaine';
        case SubscriptionPeriod.month: return '/ mois';
        case SubscriptionPeriod.year: return '/an';
    }
}

String? periodSavings(SubscriptionPeriod p) {
    switch (p) {
        case SubscriptionPeriod.week: return null;
        case SubscriptionPeriod.month: return '-10 %';
        case SubscriptionPeriod.year: return '-19 %';
    }
}


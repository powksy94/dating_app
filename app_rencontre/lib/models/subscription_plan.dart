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
    final String? yearPrice;
    final List<SubscriptionFeature> features;
    const SubscriptionPlan({
        required this.name,
        required this.color,
        required this.accentColor,
        required this.icon,
        this.badge,
        required this.weekPrice,
        required this.monthPrice,
        required this.yearPrice,
        required this.features,
    });

    String priceFor(SubscriptionPeriod period) {
        if (weekPrice ==null) return 'Gratuit';
        switch (period) {
            case SubscriptionPeriod.week: return weekPrice!;
            case SubscriptionPeriod.month: return monthPrice!;
            case SubscriptionPeriod.year: return yearPrice!;
        }
    }

    bool get isFree => weekPrice == null;
}

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
        weekPrice: '6,99 €',
        monthPrice: '27,24 €',
        yearPrice: '294,19 €',
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
        weekPrice: '9,99 €',
        monthPrice: '38,93 €',
        yearPrice: '420,44 €',
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


import 'package:flutter/material.dart';

enum SubscriptionPeriod { week, month, year }

class SubscriptionFeature {
    final String label;
    final bool included;
    const SubscriptionFeature(this.label, this included);
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

    //soon
}


enum SubscriptionPeriod { week, month, year }

String periodLabel(SubscriptionPeriod p) {
    switch (p) {
        case SubscriptionPeriod.week:  return '/ semaine';
        case SubscriptionPeriod.month: return '/ mois';
        case SubscriptionPeriod.year:  return '/an';
    }
}

String? periodSavings(SubscriptionPeriod p) {
    switch (p) {
        case SubscriptionPeriod.week:  return null;
        case SubscriptionPeriod.month: return '-10 %';
        case SubscriptionPeriod.year:  return '-19 %';
    }
}

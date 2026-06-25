import 'package:flutter/widgets.dart';
import 'package:nocturne/l10n/app_localizations.dart';

enum SubscriptionPeriod { week, month, year }

String periodName(BuildContext context, SubscriptionPeriod p) {
    final l = AppLocalizations.of(context)!;
    switch (p) {
        case SubscriptionPeriod.week:  return l.periodWeek;
        case SubscriptionPeriod.month: return l.periodMonth;
        case SubscriptionPeriod.year:  return l.periodYear;
    }
}

String periodLabel(BuildContext context, SubscriptionPeriod p) {
    switch (p) {
        case SubscriptionPeriod.week:  return '/ ${periodName(context, p)}';
        case SubscriptionPeriod.month: return '/ ${periodName(context, p)}';
        case SubscriptionPeriod.year:  return '/${periodName(context, p)}';
    }
}

String? periodSavings(SubscriptionPeriod p) {
    switch (p) {
        case SubscriptionPeriod.week:  return null;
        case SubscriptionPeriod.month: return '-10 %';
        case SubscriptionPeriod.year:  return '-19 %';
    }
}

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';

/// Prix affiché pour [period] : celui du store RevenueCat si disponible,
/// sinon la valeur codée en dur de [plan] (repli hors-ligne / avant chargement).
String livePriceFor(Offering? offering, SubscriptionPeriod period, SubscriptionPlan plan) {
  final package = _packageFor(offering, period);
  return package?.storeProduct.priceString ?? plan.priceFor(period);
}

Package? _packageFor(Offering? offering, SubscriptionPeriod period) {
  if (offering == null) return null;
  return switch (period) {
    SubscriptionPeriod.week  => offering.weekly,
    SubscriptionPeriod.month => offering.monthly,
    SubscriptionPeriod.year  => offering.annual,
  };
}

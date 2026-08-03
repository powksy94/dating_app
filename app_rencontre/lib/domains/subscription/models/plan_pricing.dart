import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';

/// Prix affiché pour [period] : celui du store RevenueCat si disponible,
/// sinon la valeur codée en dur de [plan] (repli hors-ligne / avant chargement).
String livePriceFor(Offering? offering, SubscriptionPeriod period, SubscriptionPlan plan) {
  final package = _packageFor(offering, period);
  return package?.storeProduct.priceString ?? plan.priceFor(period);
}

// Cherche d'abord via les getters standards RevenueCat, puis par identifiant
// de package personnalisé — voir la même logique dans RevenueCatService.
Package? _packageFor(Offering? offering, SubscriptionPeriod period) {
  if (offering == null) return null;
  final standard = switch (period) {
    SubscriptionPeriod.week  => offering.weekly,
    SubscriptionPeriod.month => offering.monthly,
    SubscriptionPeriod.year  => offering.annual,
  };
  if (standard != null) return standard;

  final customId = switch (period) {
    SubscriptionPeriod.week  => 'weekly',
    SubscriptionPeriod.month => 'monthly',
    SubscriptionPeriod.year  => 'yearly',
  };
  return offering.availablePackages
      .where((p) => p.identifier == customId)
      .firstOrNull;
}

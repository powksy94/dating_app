import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';

/// Price displayed for [period]: the RevenueCat store price if available,
/// otherwise the hardcoded value from [plan] (offline fallback / before loading).
String livePriceFor(Offering? offering, SubscriptionPeriod period, SubscriptionPlan plan) {
  final package = _packageFor(offering, period);
  return package?.storeProduct.priceString ?? plan.priceFor(period);
}

// Looks up via the standard RevenueCat getters first, then by custom
// package identifier. See the same logic in RevenueCatService.
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

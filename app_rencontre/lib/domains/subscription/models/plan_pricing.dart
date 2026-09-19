import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/shared/services/revenue_cat_service.dart';

/// Price displayed for [period]: the RevenueCat store price if available,
/// otherwise the hardcoded value from [plan] (offline fallback / before loading).
String livePriceFor(Offering? offering, SubscriptionPeriod period, SubscriptionPlan plan) {
  final package = offering == null
      ? null
      : RevenueCatService.packageFor(offering, period.name);
  return package?.storeProduct.priceString ?? plan.priceFor(period);
}

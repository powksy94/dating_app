import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/shared/services/revenue_cat_service.dart';

/// Localized store price for [period] (e.g. "8,49 €", "$8.99"), or null when
/// the offering is not loaded or has no matching package. There is no
/// hardcoded fallback: the UI shows a loading or unavailable state instead.
String? storePriceFor(Offering? offering, SubscriptionPeriod period) {
  if (offering == null) return null;
  return RevenueCatService.packageFor(offering, period.name)?.storeProduct.priceString;
}

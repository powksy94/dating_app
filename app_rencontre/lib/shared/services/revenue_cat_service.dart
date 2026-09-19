import 'package:flutter/services.dart' show PlatformException;
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  // ─── RevenueCat Android key ───────────────────────────────────────────────
  // https://app.revenuecat.com -> Project Settings -> API Keys
  static const _androidApiKey = 'goog_BLKdMGiGTqXqcpHbJbyIlXmnAMQ';

  // ──────────────────────────────────────────────────────────────────────────

  static Future<void> initialize() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(_androidApiKey));
  }

  /// Identifies the user after login to sync RC state.
  static Future<void> identify(String userId) async {
    try {
      await Purchases.logIn(userId);
    } catch (_) {}
  }

  /// Launches the native purchase for [planId] (nocturne / abyssal) + [periodName] (week / month / year).
  /// Returns the updated `CustomerInfo`, or `null` if the user cancels.
  static Future<CustomerInfo?> purchase(String planId, String periodName) async {
    try {
      final offerings = await Purchases.getOfferings();
      // Offering ID = planId (e.g. "nocturne" or "abyssal")
      final offering = offerings.getOffering(planId)
                    ?? offerings.current;
      if (offering == null) return null;

      final package = packageFor(offering, periodName);
      if (package == null) return null;

      final result = await Purchases.purchase(PurchaseParams.package(package));
      return result.customerInfo;
    } on PlatformException catch (e) {
      // The SDK doesn't always surface a properly typed PurchasesError,
      // a cancellation can arrive as a raw PlatformException.
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) return null;
      rethrow;
    } on PurchasesError catch (e) {
      if (e.code == PurchasesErrorCode.purchaseCancelledError) return null;
      rethrow;
    }
  }

  static Future<Offerings?> getOfferings() async {
    try {
      // The SDK can keep retrying while offline: cap the wait so the screen
      // can show its "price unavailable" state.
      return await Purchases.getOfferings().timeout(const Duration(seconds: 10));
    } catch (_) {
      return null;
    }
  }

  static Future<CustomerInfo?> restore() async {
    try {
      return await Purchases.restorePurchases();
    } catch (_) {
      return null;
    }
  }

  /// Looks first through RevenueCat's standard getters (reserved $rc_xxx
  /// identifiers), then by keyword contained in the package identifier
  /// (e.g. "Monthly Nocturne", "Yearly Abyssal") if the dashboard doesn't
  /// use the standard types, otherwise `offering.weekly`/`.monthly`/
  /// `.annual` return `null` even though the package does exist.
  /// Shared by the purchase flow and the price display so both resolve the
  /// same package. [periodName] is one of 'week', 'month', 'year'.
  static Package? packageFor(Offering offering, String periodName) {
    final standard = switch (periodName) {
      'week'  => offering.weekly,
      'month' => offering.monthly,
      'year'  => offering.annual,
      _       => offering.monthly,
    };
    if (standard != null) return standard;

    final keyword = switch (periodName) {
      'week'  => 'week',
      'month' => 'month',
      'year'  => 'year',
      _       => 'month',
    };
    return offering.availablePackages
        .where((p) => p.identifier.toLowerCase().contains(keyword))
        .firstOrNull;
  }
}

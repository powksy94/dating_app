import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  // ─── Clé RevenueCat Android ───────────────────────────────────────────────
  // https://app.revenuecat.com → Project Settings → API Keys
  static const _androidApiKey = 'test_wFoEiRuXtBbsNTGhyWgugNPVEEO';

  // ──────────────────────────────────────────────────────────────────────────

  static Future<void> initialize() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(_androidApiKey));
  }

  /// Identifie l'utilisateur après connexion pour synchroniser l'état RC.
  static Future<void> identify(String userId) async {
    try {
      await Purchases.logIn(userId);
    } catch (_) {}
  }

  /// Lance l'achat natif pour [planId] (nocturne / abyssal) + [periodName] (week / month / year).
  /// Retourne le `CustomerInfo` mis à jour, ou `null` si l'utilisateur annule.
  static Future<CustomerInfo?> purchase(String planId, String periodName) async {
    try {
      final offerings = await Purchases.getOfferings();
      // Offering ID = planId (ex: "nocturne" ou "abyssal")
      final offering = offerings.getOffering(planId)
                    ?? offerings.current;
      if (offering == null) return null;

      final package = _packageFor(offering, periodName);
      if (package == null) return null;

      return await Purchases.purchasePackage(package);
    } on PurchasesError catch (e) {
      if (e.code == PurchasesErrorCode.purchaseCancelledError) return null;
      rethrow;
    }
  }

  static Future<CustomerInfo?> restore() async {
    try {
      return await Purchases.restorePurchases();
    } catch (_) {
      return null;
    }
  }

  static Package? _packageFor(Offering offering, String periodName) =>
      switch (periodName) {
        'week'  => offering.weekly,
        'month' => offering.monthly,
        'year'  => offering.annual,
        _       => offering.monthly,
      };
}

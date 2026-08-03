import 'package:flutter/services.dart' show PlatformException;
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
    } on PlatformException catch (e) {
      // Le SDK ne remonte pas toujours une PurchasesError proprement typée —
      // une annulation peut arriver sous forme de PlatformException brute.
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
      return await Purchases.getOfferings();
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

  /// Cherche d'abord via les getters standards RevenueCat (identifiants
  /// réservés $rc_xxx), puis par mot-clé contenu dans l'identifiant du
  /// package (ex: "Monthly Nocturne", "Yearly Abyssal") si le dashboard
  /// n'utilise pas les types standards — sinon `offering.weekly`/`.monthly`/
  /// `.annual` renvoient `null` même si le package existe bel et bien.
  static Package? _packageFor(Offering offering, String periodName) {
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

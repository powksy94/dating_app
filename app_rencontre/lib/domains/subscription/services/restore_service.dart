import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/domains/subscription/services/subscription_service.dart';
import 'package:nocturne/shared/services/revenue_cat_service.dart';

/// Restaure les achats RevenueCat et synchronise le plan retrouvé avec le backend.
class RestoreService {
    /// Retourne l'id du plan restauré ('nocturne'/'abyssal'), ou `null` si rien à restaurer.
    static Future<String?> restore() async {
        final info = await RevenueCatService.restore();
        final plan = _activePlanFrom(info);
        if (plan == null) return null;

        final synced = await SubscriptionService.subscribe(plan, 'month');
        return synced ? plan : null;
    }

    static String? _activePlanFrom(CustomerInfo? info) {
        if (info == null) return null;
        final activeIds = info.entitlements.active.keys.map((k) => k.toLowerCase());
        return kSubscriptionPlanIds
            .where((id) => id != 'ombre')
            .where((id) => activeIds.any((active) => active.contains(id)))
            .firstOrNull;
    }
}

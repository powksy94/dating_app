import 'package:flutter_stripe/flutter_stripe.dart';

class StripeConfig {
  // ─── Clé publique Stripe ───────────────────────────────────────────────────
  // https://dashboard.stripe.com/apikeys → clé "Publishable key" (pk_test_/pk_live_).
  // Ce n'est PAS la clé secrète : celle-ci ne doit jamais apparaître côté app,
  // elle vit uniquement dans STRIPE_SECRET_KEY côté backend.
  static const _publishableKey = 'pk_test_51TyyY7QqofIu1IxLY2Ne1u6CaLi1C4D8ftavlmbLyGMUDE1khONMzIbtm9Urq6TJk1yaxgDegWzASIPMwrDtvawu00LptnnBj1';

  /// Ne doit jamais faire planter le démarrage de l'app : un échec ici
  /// désactive juste le paiement d'évènements, pas le reste de l'app.
  static Future<void> initialize() async {
    try {
      Stripe.publishableKey = _publishableKey;
      await Stripe.instance.applySettings();
    } catch (_) {}
  }
}

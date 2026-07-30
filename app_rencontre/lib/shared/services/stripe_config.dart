import 'package:flutter_stripe/flutter_stripe.dart';

class StripeConfig {
  // ─── Clé publique Stripe ───────────────────────────────────────────────────
  // https://dashboard.stripe.com/apikeys → clé "Publishable key" (pk_test_/pk_live_).
  // Ce n'est PAS la clé secrète : celle-ci ne doit jamais apparaître côté app,
  // elle vit uniquement dans STRIPE_SECRET_KEY côté backend.
  static const _publishableKey = 'pk_test_REPLACE_ME';

  static Future<void> initialize() async {
    Stripe.publishableKey = _publishableKey;
    await Stripe.instance.applySettings();
  }
}

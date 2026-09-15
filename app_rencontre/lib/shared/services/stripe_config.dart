import 'package:flutter_stripe/flutter_stripe.dart';

class StripeConfig {
  // ─── Stripe publishable key ───────────────────────────────────────────────────
  // https://dashboard.stripe.com/apikeys -> "Publishable key" (pk_test_/pk_live_).
  // This is NOT the secret key: that one must never appear on the app side,
  // it only lives in STRIPE_SECRET_KEY on the backend.
  static const _publishableKey = 'pk_test_51TyyY7QqofIu1IxLY2Ne1u6CaLi1C4D8ftavlmbLyGMUDE1khONMzIbtm9Urq6TJk1yaxgDegWzASIPMwrDtvawu00LptnnBj1';

  /// Must never crash app startup: a failure here only disables
  /// event payment, not the rest of the app.
  static Future<void> initialize() async {
    try {
      Stripe.publishableKey = _publishableKey;
      await Stripe.instance.applySettings();
    } catch (_) {}
  }
}

import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:nocturne/shared/services/api_service.dart';

/// Paye un évènement payant via la Payment Sheet Stripe, puis confirme
/// l'inscription côté backend une fois le paiement réussi.
class EventPaymentService {
  static Future<bool> pay(String eventId) async {
    final clientSecret = await _createPaymentIntent(eventId);
    if (clientSecret == null) return false;

    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Nocturne',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } on StripeException {
      return false;
    }

    final paymentIntentId = clientSecret.split('_secret_').first;
    return _confirmPayment(paymentIntentId);
  }

  static Future<String?> _createPaymentIntent(String eventId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/events/$eventId/payment-intent'),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return data['clientSecret'] as String?;
      }
    } catch (_) {}
    return null;
  }

  static Future<bool> _confirmPayment(String paymentIntentId) async {
    try {
      final headers = await ApiService.authHeaders();
      final res = await http.post(
        Uri.parse('${ApiService.baseUrl}/events/confirm-payment'),
        headers: headers,
        body: jsonEncode({'paymentIntentId': paymentIntentId}),
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

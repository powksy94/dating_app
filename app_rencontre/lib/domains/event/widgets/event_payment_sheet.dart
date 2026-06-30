import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';

class EventPaymentSheet extends StatelessWidget {
  final EventModel event;
  final Future<void> Function() onConfirm;

  const EventPaymentSheet({
    super.key,
    required this.event,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final l      = AppLocalizations.of(context)!;
    final amount = event.price?.toStringAsFixed(0) ?? '?';

    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, 24 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF3D2A4A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Titre + icône paiement
          Row(children: [
            const Icon(Icons.credit_card, color: Color(0xFF7B00D4), size: 20),
            const SizedBox(width: 10),
            Text(
              l.eventPaymentSheetTitle,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ]),
          const SizedBox(height: 16),

          // Infos événement
          _row(Icons.music_note_outlined,     event.title),
          const SizedBox(height: 8),
          _row(Icons.calendar_today_outlined, formatEventDate(context, event.date)),
          const SizedBox(height: 8),
          _row(Icons.location_on_outlined,    event.city),
          const SizedBox(height: 16),

          // Prix mis en avant
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0A1F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF7B00D4), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14)),
                Text('$amount €',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bouton payer
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                l.eventPaymentBtn(amount),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Notice mode test
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1A3A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                l.eventPaymentTestNotice,
                style: const TextStyle(color: Color(0xFF7A6A8A), fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Annuler
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.eventBtnCancel,
                  style: const TextStyle(color: Color(0xFF5A4A6A))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text) => Row(children: [
    Icon(icon, size: 15, color: const Color(0xFF5A4A6A)),
    const SizedBox(width: 10),
    Expanded(
        child: Text(text,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13))),
  ]);
}

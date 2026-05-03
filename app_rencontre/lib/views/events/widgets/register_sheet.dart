import 'package:flutter/material.dart';
import '../../../models/event_model.dart';

class RegisterSheet extends StatelessWidget {
  final EventModel event;
  final Future<void> Function() onConfirm;

  const RegisterSheet({
    super.key,
    required this.event,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
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
          Text(
            event.isAttending
                ? "Se désinscrire de l'événement"
                : "Confirmer l'inscription",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _row(Icons.music_note_outlined,         event.title),
          const SizedBox(height: 8),
          _row(Icons.calendar_today_outlined,     _formattedDate()),
          const SizedBox(height: 8),
          _row(Icons.location_on_outlined,        event.city),
          const SizedBox(height: 8),
          _row(
            Icons.confirmation_number_outlined,
            event.isFree ? 'Gratuit' : '${event.price?.toStringAsFixed(0)} €',
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: event.isAttending
                    ? const Color(0xFF8B0000)
                    : const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                event.isAttending
                    ? 'Confirmer la désinscription'
                    : 'Je participe !',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler',
                  style: TextStyle(color: Color(0xFF5A4A6A))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF5A4A6A)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: Color(0xFFAA9AB5), fontSize: 13)),
        ),
      ],
    );
  }

  String _formattedDate() {
    final d = event.date;
    const months = [
      '', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
    ];
    return '${d.day} ${months[d.month]} ${d.year} à '
        '${d.hour.toString().padLeft(2, '0')}h'
        '${d.minute.toString().padLeft(2, '0')}';
  }
}

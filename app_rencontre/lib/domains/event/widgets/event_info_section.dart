import 'package:flutter/material.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/shared/widgets/common/section_block.dart';

class EventInfoSection extends StatelessWidget {
  final EventModel event;

  const EventInfoSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      title: 'INFOS',
      child: Column(
        children: [
          _row(Icons.calendar_today_outlined, _formattedDate()),
          const SizedBox(height: 10),
          _row(Icons.location_on_outlined, event.address),
          const SizedBox(height: 10),
          _row(
            Icons.confirmation_number_outlined,
            event.isFree ? 'Gratuit' : '${event.price?.toStringAsFixed(0)} €',
            color: event.isFree
                ? const Color(0xFF2ECC71)
                : const Color(0xFFD400FF),
          ),
          const SizedBox(height: 10),
          _row(
            Icons.people_outline,
            event.capacityMax != null
                ? '${event.capacityMin}–${event.capacityMax} places'
                : '${event.capacityMin} places',
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color ?? const Color(0xFF5A4A6A)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: color ?? const Color(0xFFAA9AB5), fontSize: 14)),
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

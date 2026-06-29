import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';
import 'package:nocturne/shared/widgets/common/section_block.dart';

class EventInfoSection extends StatelessWidget {
  final EventModel event;

  const EventInfoSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SectionBlock(
      title: l.eventSectionInfo,
      child: Column(
        children: [
          _row(Icons.calendar_today_outlined, formatEventDate(context, event.date)),
          const SizedBox(height: 10),
          _row(Icons.location_on_outlined, event.address),
          const SizedBox(height: 10),
          _row(
            Icons.confirmation_number_outlined,
            event.isFree ? l.eventPriceFree : '${event.price?.toStringAsFixed(0)} €',
            color: event.isFree
                ? const Color(0xFF2ECC71)
                : const Color(0xFFD400FF),
          ),
          const SizedBox(height: 10),
          _row(
            Icons.people_outline,
            event.capacityMax != null
                ? l.eventCapacityRange(event.capacityMin, event.capacityMax!)
                : l.eventCapacityMin(event.capacityMin),
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
}

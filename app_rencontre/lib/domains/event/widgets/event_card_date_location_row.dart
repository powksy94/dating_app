import 'package:flutter/material.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';

class EventCardDateLocationRow extends StatelessWidget {
  final DateTime date;
  final String city;
  final double? distance;

  const EventCardDateLocationRow({
    super.key,
    required this.date,
    required this.city,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = formatEventDateCompact(context, date);

    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined,
            size: 13, color: Color(0xFF5A4A6A)),
        const SizedBox(width: 4),
        Text(dateStr,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
        const SizedBox(width: 12),
        const Icon(Icons.location_on_outlined,
            size: 13, color: Color(0xFF5A4A6A)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            distance != null ? '$city · $distance km' : city,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

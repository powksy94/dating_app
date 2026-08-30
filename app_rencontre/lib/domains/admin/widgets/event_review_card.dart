import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class EventReviewCard extends StatelessWidget {
  final Map<String, dynamic> event;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const EventReviewCard({
    super.key,
    required this.event,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final title       = event['title'] as String? ?? '';
    final description = event['description'] as String? ?? '';
    final city        = event['city'] as String? ?? '';
    final isFree      = event['isFree'] as bool? ?? true;
    final price       = event['price'];
    final priceLabel  = isFree ? l.eventReviewFree : '$price €';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D0040)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 10),
          Row(children: [
            const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF5A4A6A)),
            const SizedBox(width: 4),
            Expanded(
              child: Text(city,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
            ),
            Text(priceLabel,
                style: const TextStyle(
                    color: Color(0xFF7B00D4), fontSize: 12, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onReject,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  side: const BorderSide(color: Color(0xFF7F1D1D)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.eventReviewBtnReject),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: onApprove,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B00D4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.eventReviewBtnApprove),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

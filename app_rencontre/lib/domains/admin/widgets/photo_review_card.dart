import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class PhotoReviewCard extends StatefulWidget {
  final Map<String, dynamic> photo;
  final Future<void> Function() onApprove;
  final Future<void> Function() onReject;

  const PhotoReviewCard({
    super.key,
    required this.photo,
    required this.onApprove,
    required this.onReject,
  });

  @override
  State<PhotoReviewCard> createState() => _PhotoReviewCardState();
}

class _PhotoReviewCardState extends State<PhotoReviewCard> {
  bool _loading = false;

  Future<void> _handle(Future<void> Function() action) async {
    setState(() => _loading = true);
    await action();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final photo       = widget.photo;
    final url         = photo['url'] as String? ?? '';
    final ownerEmail  = photo['ownerEmail'] as String? ?? '';
    final labels      = (photo['moderationLabels'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(url, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Text(ownerEmail,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          if (labels.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: labels.map((label) {
                final name = label['name'] as String? ?? '';
                final confidence = (label['confidence'] as num?)?.round() ?? 0;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D0040),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('$name $confidence%',
                      style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11)),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _loading ? null : () => _handle(widget.onReject),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  side: const BorderSide(color: Color(0xFF7F1D1D)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.photoReviewBtnReject),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _loading ? null : () => _handle(widget.onApprove),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B00D4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _loading
                    ? const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(l.photoReviewBtnApprove),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

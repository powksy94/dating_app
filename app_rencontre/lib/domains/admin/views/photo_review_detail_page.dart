import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/photo_review_actions.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';

class PhotoReviewDetailPage extends StatefulWidget {
  final Map<String, dynamic> photo;
  const PhotoReviewDetailPage({super.key, required this.photo});

  @override
  State<PhotoReviewDetailPage> createState() => _PhotoReviewDetailPageState();
}

class _PhotoReviewDetailPageState extends State<PhotoReviewDetailPage> {
  bool _pending = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _pending = true);
    await action();
    if (mounted) setState(() => _pending = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final photoId = widget.photo['_id'] as String;
    final url = widget.photo['url'] as String? ?? '';
    final ownerEmail = widget.photo['ownerEmail'] as String? ?? '';
    final labels = (widget.photo['moderationLabels'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    final createdAt = DateTime.tryParse(widget.photo['createdAt'] as String? ?? '');

    final actions = PhotoReviewActions(
      context: context,
      onDecided: (_, approved) => Navigator.pop(context, {'action': approved ? 'approved' : 'rejected'}),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0010),
        elevation: 0,
        title: Text(l.photoReviewDetailTitle,
            style: const TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(url, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0A1F),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF2D0040)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ownerEmail,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                if (createdAt != null) ...[
                  const SizedBox(height: 4),
                  Text('${l.photoReviewDateLabel} ${formatEventDateCompact(context, createdAt)}',
                      style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
                ],
                if (labels.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(l.photoReviewLabelsLabel,
                      style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...labels.map((label) {
                    final name = label['name'] as String? ?? '';
                    final confidence = (label['confidence'] as num?)?.round() ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(name,
                                style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 14)),
                          ),
                          Text('$confidence%',
                              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13)),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _pending ? null : () => _run(() => actions.reject(photoId)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  side: const BorderSide(color: Color(0xFF7F1D1D)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(l.photoReviewBtnReject),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _pending ? null : () => _run(() => actions.approve(photoId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B00D4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _pending
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

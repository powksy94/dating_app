import 'package:flutter/material.dart';
import 'package:nocturne/domains/admin/utils/moderation_label_fr.dart';

class PhotoReviewCard extends StatelessWidget {
  final Map<String, dynamic> photo;
  final VoidCallback onTap;

  const PhotoReviewCard({
    super.key,
    required this.photo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final url = photo['url'] as String? ?? '';
    final ownerEmail = photo['ownerEmail'] as String? ?? '';
    final labels = (photo['moderationLabels'] as List?)?.cast<Map<String, dynamic>>() ?? const [];

    return Material(
      color: const Color(0xFF1A0A1F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2D0040)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 52,
                  height: 52,
                  child: Image.network(url, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ownerEmail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    if (labels.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        labels.map((l) => moderationLabelFr(l['name'] as String? ?? '')).join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Color(0xFF5A4A6A), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

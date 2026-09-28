import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// A photo still waiting for moderation: read-only, since only an admin
/// decides its fate (see photo_review_page.dart) — nothing to remove here.
class PhotoTilePending extends StatelessWidget {
  final String url;
  const PhotoTilePending({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            url,
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.4),
            colorBlendMode: BlendMode.darken,
          ),
          const Center(
            child: Icon(Icons.hourglass_top_outlined, color: Colors.white, size: 22),
          ),
          Positioned(
            bottom: 4, left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF8A6A00),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(AppLocalizations.of(context)!.profileBadgePending,
                  style: const TextStyle(color: Colors.white, fontSize: 9)),
            ),
          ),
        ],
      ),
    );
  }
}

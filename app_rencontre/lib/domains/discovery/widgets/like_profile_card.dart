import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/models/liked_profile.dart';

class LikeProfileCard extends StatelessWidget {
  final LikedProfile profile;
  const LikeProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final photo = profile.photos.isNotEmpty ? profile.photos.first : profile.avatarUrl;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1A0A1F),
        border: Border.all(
          color: profile.isMatch ? const Color(0xFF7B00D4) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: profile.isMatch
            ? [BoxShadow(color: const Color(0xFF7B00D4).withValues(alpha: 0.3), blurRadius: 12)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            photo.isNotEmpty
                ? Image.network(photo, fit: BoxFit.cover)
                : Container(color: const Color(0xFF2D1A3A), child: const Icon(Icons.person, color: Color(0xFF7B00D4), size: 48)),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xDD0D0010)],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),
            ),
            if (profile.isMatch)
              Positioned(
                top: 8, right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF7B00D4), borderRadius: BorderRadius.circular(12)),
                  child: Text(AppLocalizations.of(context)!.discoveryBadgeMatch, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
            Positioned(
              left: 10, right: 10, bottom: 10,
              child: Text(
                profile.age != null ? '${profile.username}, ${profile.age}' : profile.username,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

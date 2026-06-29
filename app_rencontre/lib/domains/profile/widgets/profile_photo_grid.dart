import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ProfilePhotoGrid extends StatelessWidget {
  final List<String> photos;
  final int photoLimit;
  final void Function(int index) onPhotoTap;
  final VoidCallback onLockedTap;

  const ProfilePhotoGrid({
    super.key,
    required this.photos,
    required this.photoLimit,
    required this.onPhotoTap,
    required this.onLockedTap,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.profileSectionPhotos,
          style: const TextStyle(
            color: Color(0xFF7B00D4),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final locked = index >= photoLimit;
            return GestureDetector(
              onTap: locked ? onLockedTap : () => onPhotoTap(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      photos[index],
                      fit: BoxFit.cover,
                    ),
                    if (locked) ...[
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                            color: Colors.black.withValues(alpha: 0.35)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock,
                              color: Color(0xFF7B00D4), size: 28),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B00D4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              l.profileBadgePremium,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

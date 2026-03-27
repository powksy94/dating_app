import 'package:flutter/material.dart';
import '../models/alternative_profile.dart';

class ProfileCard extends StatelessWidget {
  final AlternativeProfile profile;
  final VoidCallback? onEdit;
  const ProfileCard({super.key, required this.profile, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 540,
        child: Stack(
          children: [
            _Background(profile.avatarUrl),
            _GothGradient(),
            if (onEdit !=null)
              Positioned(
                top: 12, right: 12,
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A0A1F).withOpacity(0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF7B00D4)),
                    ),
                    child: const Icon(Icons.edit, color: Color(0xFF7B00D4), size: 20),
                  ),
                ),
              ),
            Positioned(
              left: 18, right: 18, bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _UsernameRow(profile),
                  const SizedBox(height: 10),
                  if (profile.aesthetics.isNotEmpty)
                    Wrap(
                      spacing: 6, runSpacing: 6,
                      children: profile.aesthetics
                          .map((a) => AestheticChip(label: a))
                          .toList(),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    profile.bio,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withOpacity(0.85)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final String url;
  const _Background(this.url);

  @override
  Widget build(BuildContext context) => Positioned.fill(
        child: url.isNotEmpty
            ? Image.network(url, fit: BoxFit.cover)
            : Container(color: const Color(0xFF1A0A1F)),
      );
}

class _GothGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xFF0D0009).withOpacity(0.92),
                Colors.transparent,
              ],
              stops: const [0.0, 0.6],
            ),
          ),
        ),
      );
}

class _UsernameRow extends StatelessWidget {
  final AlternativeProfile profile;
  const _UsernameRow(this.profile);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          profile.username,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
          ),
        ),
        if (profile.age != null) ...[
          const SizedBox(width: 8),
          Text(
            '${profile.age}',
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 20),
          ),
        ],
        if (profile.pronouns != null) ...[
          const SizedBox(width: 8),
          Text(
            profile.pronouns!,
            style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 14),
          ),
        ],
      ],
    );
  }
}

class AestheticChip extends StatelessWidget {
  final String label;
  const AestheticChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final color = _aestheticColor(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 0.8),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

Color _aestheticColor(String aesthetic) {
  switch (aesthetic.toLowerCase()) {
    case 'goth':       return const Color(0xFF4A0072);
    case 'cyber-goth': return const Color(0xFF006B6B);
    case 'nu-goth':    return const Color(0xFF2D2D2D);
    case 'deathrock':  return const Color(0xFF6B0000);
    case 'dark wave':  return const Color(0xFF003366);
    case 'industrial': return const Color(0xFF3D3D3D);
    case 'post-punk':  return const Color(0xFF4A1500);
    case 'metal':      return const Color(0xFF1A1A2E);
    case 'dark folk':  return const Color(0xFF1A2E00);
    case 'punk':       return const Color(0xFF7A0000);
    case 'emo':        return const Color(0xFF2D002D);
    case 'steampunk':  return const Color(0xFF2E1B00);
    default:           return const Color(0xFF1A0A1F);
  }
}

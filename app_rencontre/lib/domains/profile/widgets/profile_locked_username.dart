import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ProfileLockedUsername extends StatelessWidget {
  final String username;
  const ProfileLockedUsername({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A0A1F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2D0040)),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock_outline,
                  size: 14, color: Color(0xFF5A4A6A)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xFF5A4A6A), fontSize: 14)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(AppLocalizations.of(context)!.profileUsernameImmutableNote,
            style: const TextStyle(color: Color(0xFF3D2A4A), fontSize: 11)),
      ],
    );
  }
}

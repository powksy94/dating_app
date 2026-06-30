import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/profile/widgets/profile_card.dart';
import 'package:nocturne/domains/profile/widgets/profile_tag_wrap.dart';
import 'package:nocturne/domains/profile/widgets/profile_social_link.dart';
import 'package:nocturne/shared/widgets/common/section_block.dart';

class ProfileDetailsSection extends StatelessWidget {
  final AlternativeProfile profile;
  final bool showBio;
  const ProfileDetailsSection({super.key, required this.profile, this.showBio = true});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBio)
          SectionBlock(
            title: l.profileSectionBio,
            child: Text(profile.bio,
                style: const TextStyle(
                    color: Color(0xFFAA9AB5), fontSize: 16)),
          ),

        if (profile.musicGenres.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionMusicGenres,
            child: ProfileTagWrap(profile.musicGenres,
                color: const Color(0xFF4A0072)),
          ),
        ],

        if (profile.musicVibes.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionVibe,
            child: ProfileTagWrap(profile.musicVibes,
                color: const Color(0xFF003366)),
          ),
        ],

        if (profile.aesthetics.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionAesthetics,
            child: Wrap(
              spacing: 8, runSpacing: 8,
              children: profile.aesthetics
                  .map((a) => AestheticChip(label: a))
                  .toList(),
            ),
          ),
        ],

        if (profile.soundIntensity.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionSoundIntensity,
            child: ProfileTagWrap(profile.soundIntensity,
                color: const Color(0xFF6B0000)),
          ),
        ],

        if (profile.musicEras.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionEra,
            child: ProfileTagWrap(profile.musicEras,
                color: const Color(0xFF2E1B00)),
          ),
        ],

        if (profile.discoveryFormats.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionDiscovery,
            child: ProfileTagWrap(profile.discoveryFormats,
                color: const Color(0xFF1A2E00)),
          ),
        ],

        if (profile.favoriteBands.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionFavoriteBands,
            child: Text(profile.favoriteBands.join(' · '),
                style: const TextStyle(color: Color(0xFFE8E0EE))),
          ),
        ],

        if (profile.upcomingEvents.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionUpcomingEvents,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: profile.upcomingEvents
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(children: [
                          const Icon(Icons.event,
                              size: 16, color: Color(0xFF7B00D4)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(e,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xFFE8E0EE))),
                          ),
                        ]),
                      ))
                  .toList(),
            ),
          ),
        ],

        if (profile.socialLinks.isNotEmpty) ...[
          const SizedBox(height: 16),
          SectionBlock(
            title: l.profileSectionLinks,
            child: Wrap(
              spacing: 10, runSpacing: 8,
              children: profile.socialLinks.entries
                  .map((e) => ProfileSocialLink(platform: e.key, url: e.value))
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }
}

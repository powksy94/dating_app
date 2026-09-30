import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nocturne/domains/home/widgets/founding_gift_reveal.dart';
import 'package:nocturne/domains/onboarding/views/onboarding_tour_page.dart';
import 'package:nocturne/domains/settings/widgets/section_header.dart';
import 'package:nocturne/domains/settings/widgets/action_tile.dart';

/// Debug-build-only tools, invisible in release builds. Lets a dev replay
/// visual flows (the founding-member gift reveal, the post-registration
/// onboarding tour) without the real-world conditions that trigger them
/// (a fresh, still-'pending' account; a brand new registration).
class DebugSection extends StatelessWidget {
  const DebugSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('DEBUG'),
        ActionTile(
          icon: Icons.mail_lock_outlined,
          label: 'Preview founding gift reveal',
          onTap: () => Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => FoundingGiftReveal(
              onClaim: () async {
                await Future.delayed(const Duration(milliseconds: 600));
                return true;
              },
            ),
          )),
        ),
        ActionTile(
          icon: Icons.auto_stories_outlined,
          label: 'Preview onboarding tour',
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => OnboardingTourPage(onFinished: () => Navigator.pop(context)),
          )),
        ),
      ],
    );
  }
}

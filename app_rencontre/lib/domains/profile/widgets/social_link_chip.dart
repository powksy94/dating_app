import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nocturne/domains/profile/services/social_link_detector.dart';

/// One profile-link pastille: filled violet once a link is set for that
/// platform, outlined otherwise. Tapping it is the only way to add, edit or
/// remove that platform's link (see ProfileMenu).
class SocialLinkChip extends StatelessWidget {
  final String platform;
  final bool isSet;
  final bool enabled;
  final VoidCallback onTap;

  const SocialLinkChip({
    super.key,
    required this.platform,
    required this.isSet,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: FaIcon(
        socialPlatformIcon(platform),
        size: 16,
        color: isSet ? Colors.white : const Color(0xFF7B00D4),
      ),
      label: Text(platform, style: TextStyle(color: isSet ? Colors.white : const Color(0xFFAA9AB5))),
      backgroundColor: isSet ? const Color(0xFF4A0072) : const Color(0xFF1A0A1F),
      side: BorderSide(color: isSet ? const Color(0xFF7B00D4) : const Color(0xFF3D2A4A)),
      onPressed: enabled ? onTap : null,
    );
  }
}

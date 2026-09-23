import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nocturne/domains/profile/services/social_link_detector.dart';

class ProfileSocialLink extends StatelessWidget {
  final String platform;
  final String url;
  const ProfileSocialLink({super.key, required this.platform, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF7B00D4), width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(socialPlatformIcon(platform),
                size: 16, color: const Color(0xFF7B00D4)),
            const SizedBox(width: 6),
            Text(platform,
                style: const TextStyle(
                    color: Color(0xFFE8E0EE), fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

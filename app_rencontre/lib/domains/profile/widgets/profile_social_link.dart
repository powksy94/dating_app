import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Icon(_platformIcon(platform),
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

  IconData _platformIcon(String p) {
    switch (p.toLowerCase()) {
      case 'instagram': return Icons.camera_alt;
      case 'bandcamp':  return Icons.music_note;
      case 'lastfm':    return Icons.bar_chart;
      case 'tumblr':    return Icons.dashboard;
      default:          return Icons.link;
    }
  }
}

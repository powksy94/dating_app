import 'package:flutter/material.dart';
import 'package:nocturne/domains/chat/services/starter_texts.dart';

/// One tappable conversation starter: the banner announcing what the two people
/// have in common (when there is one), then the message that would be sent.
class StarterOptionTile extends StatelessWidget {
  final StarterText text;
  final VoidCallback onTap;

  const StarterOptionTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final banner = text.banner;
    return Material(
      color: const Color(0xFF1A0A1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFF3D2A4A)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (banner != null) ...[
                Text(
                  banner,
                  style: const TextStyle(
                    color: Color(0xFF9B4DFF),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 6),
              ],
              Text(
                text.message,
                style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 14, height: 1.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

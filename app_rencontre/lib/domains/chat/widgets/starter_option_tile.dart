import 'package:flutter/material.dart';
import 'package:nocturne/domains/chat/services/starter_texts.dart';

/// One tappable conversation starter: the banner announcing what the two people
/// have in common (when there is one), then the message that would be sent.
/// A card built on a common ground has a violet accent bar, a classic one a dim bar.
class StarterOptionTile extends StatelessWidget {
  final StarterText text;
  final VoidCallback onTap;

  const StarterOptionTile({super.key, required this.text, required this.onTap});

  static const _accent = Color(0xFF7B00D4);

  @override
  Widget build(BuildContext context) {
    final banner = text.banner;
    final radius = BorderRadius.circular(16);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(color: _accent.withValues(alpha: 0.10), blurRadius: 14, offset: const Offset(0, 4)),
        ],
      ),
      child: Material(
        color: const Color(0xFF1A0A1F),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: const BorderSide(color: Color(0xFF3D2A4A)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: _accent.withValues(alpha: 0.18),
          highlightColor: _accent.withValues(alpha: 0.08),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: banner != null ? _accent : const Color(0xFF3D2A4A)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (banner != null) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 1),
                                child: Icon(Icons.auto_awesome, size: 13, color: Color(0xFF9B4DFF)),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  banner,
                                  style: const TextStyle(
                                    color: Color(0xFF9B4DFF),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                        Text(
                          text.message,
                          style: const TextStyle(
                            color: Color(0xFFF0E9F5),
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Center(
                    child: Icon(Icons.send_rounded, size: 17, color: _accent.withValues(alpha: 0.75)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

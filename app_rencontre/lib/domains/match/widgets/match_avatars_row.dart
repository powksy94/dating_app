import 'package:flutter/material.dart';

class MatchAvatarRow extends StatelessWidget {
    final String myAvatarUrl;
    final String matchAvatarUrl;
    final String matchUsername;
    final double slideValue;
    final double glowValue;

    const MatchAvatarRow({
        super.key,
        required this.myAvatarUrl,
        required this.matchAvatarUrl,
        required this.matchUsername,
        required this.slideValue,
        required this.glowValue,
    });

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: 160,
            child: Stack(
                alignment: Alignment.center,
                children: [
                    // Avatar gauche (moi)
                    Transform.translate(
                        offset: Offset(-90 + (90 * slideValue) - 60, 0),
                        child: Opacity(
                            opacity: slideValue,
                            child: _Avatar(
                                url: myAvatarUrl,
                                label: 'Toi',
                                size: 110,
                                borderColor: const Color(0xFF7B00D4),
                            ),
                        ),
                    ),

                    // Icône centrale lune avec glow
                    Opacity(
                        opacity: slideValue,
                        child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF0D0010),
                                border: Border.all(
                                    color: const Color(0xFF7B00D4),
                                    width: 1.5,
                                ),
                                boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xFF7B00D4)
                                            .withValues(alpha: 0.4 + 0.3 * glowValue),
                                        blurRadius: 16 + 8 * glowValue,
                                        spreadRadius: 2,
                                    ),
                                ],
                            ),
                            child: const Icon(
                                Icons.nightlight,
                                color: Color(0xFF7B00D4),
                                size: 22,
                            ),
                        ),
                    ),

                    // Avatar droite (match)
                    Transform.translate(
                        offset: Offset(90 - (90 * slideValue) + 60, 0),
                        child: Opacity(
                            opacity: slideValue,
                            child: _Avatar(
                                url: matchAvatarUrl,
                                label: matchUsername,
                                size: 110,
                                borderColor: const Color(0xFFD400FF),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}

class _Avatar extends StatelessWidget {
    final String url;
    final String label;
    final double size;
    final Color borderColor;
    const _Avatar({
        required this.url,
        required this.label,
        required this.size,
        required this.borderColor,
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 2.5),
                        boxShadow: [
                            BoxShadow(
                                color: borderColor.withValues(alpha: 0.4),
                                blurRadius: 16,
                                spreadRadius: 2,
                            ),
                        ],
                    ),
                    child: ClipOval(
                        child: url.isNotEmpty
                            ? Image.network(url, fit: BoxFit.cover)
                            : Container(
                                color: const Color(0xFF1A0A1F),
                                child: const Icon(
                                    Icons.person,
                                    color: Color(0xFF7B00D4),
                                    size: 48,
                                ),
                            ),
                    ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                    width: size,
                    child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                ),
            ],
        );
    }
}
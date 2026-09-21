import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/match/widgets/match_burst_painter.dart';

class MatchAvatarRow extends StatelessWidget {
    final String myAvatarUrl;
    final String matchAvatarUrl;
    final String matchUsername;
    /// Slide-in progress. It may go a little over 1 while the avatars bounce.
    final double slideValue;
    final double glowValue;
    /// Progress of the rings spreading when the two people meet.
    final double burstValue;

    // Distance from the middle to each avatar once they have met: wide enough
    // for the moon (44 wide) to sit between two 110 wide avatars.
    static const double _gap = 78;
    static const double _travel = 90;

    const MatchAvatarRow({
        super.key,
        required this.myAvatarUrl,
        required this.matchAvatarUrl,
        required this.matchUsername,
        required this.slideValue,
        required this.glowValue,
        required this.burstValue,
    });

    @override
    Widget build(BuildContext context) {
        final visible = slideValue.clamp(0.0, 1.0);
        // The moon appears with a spring once the avatars are nearly together.
        final moonScale = Curves.elasticOut.transform(((slideValue - 0.55) / 0.45).clamp(0.0, 1.0));

        return SizedBox(
            height: 160,
            child: Stack(
                alignment: Alignment.center,
                // The rings spread well beyond the row.
                clipBehavior: Clip.none,
                children: [
                    CustomPaint(
                        size: const Size(340, 160),
                        painter: MatchBurstPainter(burstValue),
                    ),

                    // Left avatar (me)
                    Transform.translate(
                        offset: Offset(-(_gap + _travel) + _travel * slideValue, 0),
                        child: Opacity(
                            opacity: visible,
                            child: _Avatar(
                                url: myAvatarUrl,
                                label: AppLocalizations.of(context)!.matchAvatarYou,
                                size: 110,
                                borderColor: const Color(0xFF7B00D4),
                            ),
                        ),
                    ),

                    // Central moon icon with glow
                    Transform.scale(
                        scale: moonScale,
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

                    // Right avatar (match)
                    Transform.translate(
                        offset: Offset((_gap + _travel) - _travel * slideValue, 0),
                        child: Opacity(
                            opacity: visible,
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

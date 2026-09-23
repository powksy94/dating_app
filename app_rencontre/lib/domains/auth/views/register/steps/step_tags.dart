import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/core/music_tags.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';
import 'package:nocturne/domains/profile/models/favorite_band.dart';
import 'package:nocturne/domains/profile/widgets/favorite_bands_field.dart';

class StepTags extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepTags({super.key, required this.onNext});

    @override
    State<StepTags> createState() => _StepTagsState();
}

class _StepTagsState extends State<StepTags> {
    List<FavoriteBand> _favoriteBands = [];
    final List<String> _genres        = [];
    final List<String> _vibes         = [];
    final List<String> _aesthetics    = [];
    final List<String> _intensity     = [];
    final List<String> _eras          = [];
    final List<String> _discovery     = [];
    String? _error;

    void _toggle(List<String> list, String tag) {
        setState(() => list.contains(tag) ? list.remove(tag) : list.add(tag));
    }

    void _next() {
        if (_genres.isEmpty || _aesthetics.isEmpty) {
            setState(() => _error = AppLocalizations.of(context)!.authErrorSelectGenreAesthetic);
            return;
        }
        widget.onNext({
            'musicGenres':          _genres,
            'musicVibes':           _vibes,
            'aesthetics':           _aesthetics,
            'soundIntensity':       _intensity,
            'musicEras':            _eras,
            'discoveryFormats':     _discovery,
            'favoriteBands':        _favoriteBands.map((b) => b.toJson()).toList(),
        });
    }

    Widget _section(String title, List<String> options, List<String> selected, int delayMs) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    title,
                    style: const TextStyle(
                        color: Color(0xFF7B00D4),
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                    ),
                ).animate().fadeIn(delay: Duration(milliseconds: delayMs), duration: 400.ms),
                const SizedBox(height: 10),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: options.map((tag) => FilterChip(
                        label: Text(tag),
                        selected: selected.contains(tag),
                        onSelected: (_) => _toggle(selected, tag),
                        selectedColor: const Color(0xFF7B00D4),
                        checkmarkColor: Colors.white,
                    )).toList(),
                ).animate().fadeIn(delay: Duration(milliseconds: delayMs), duration: 400.ms),
                const SizedBox(height: 24),
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        final l = AppLocalizations.of(context)!;
        return AnimatedStep(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(height: 32),
                        Text(
                            l.authStepTagsTitle,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                            l.authStepTagsSubtitle,
                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        _section(l.authSectionMusicGenres,      kMusicGenres,       _genres,        300),
                        _section(l.authSectionMusicVibes,       kMusicVibes,        _vibes,         400),
                        _section(l.authSectionAesthetics,       kAesthetics,        _aesthetics,    500),
                        _section(l.authSectionSoundIntensity,   kSoundIntensity,    _intensity,     600),
                        _section(l.authSectionMusicEras,        kMusicEras,         _eras,          700),
                        _section(l.authSectionDiscoveryFormats, kDiscoveryFormats,  _discovery,     800),

                        _section(l.authSectionFavoriteBands, const [], const [], 900),
                        FavoriteBandsField(
                            bands: _favoriteBands,
                            hint: l.authHintBands,
                            onChanged: (bands) => setState(() => _favoriteBands = bands),
                        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                        const SizedBox(height: 24),

                        if (_error != null) ...[
                            Text(_error!, style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13)),
                            const SizedBox(height: 12),
                        ],
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _next,
                                child: Text(l.authBtnContinue),
                            ),
                        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}
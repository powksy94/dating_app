import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/core/music_tags.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';

class StepTags extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepTags({super.key, required this.onNext});

    @override
    State<StepTags> createState() => _StepTagsState();
}

class _StepTagsState extends State<StepTags> {
    final TextEditingController _bandCtrl = TextEditingController();
    List<String> _favoriteBands = [];
    List<String> _genres        = [];
    List<String> _vibes         = [];
    List<String> _aesthetics    = [];
    List<String> _intensity     = [];
    List<String> _eras          = [];
    List<String> _discovery     = [];
    String? _error;

    @override
    void dispose() {
        _bandCtrl.dispose();
        super.dispose();
    }

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
            'favoriteBands':        _favoriteBands,
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

                        _section(l.authSectionFavoriteBands, [], _favoriteBands, 900),
                        Row(
                            children: [
                                Expanded(
                                    child: TextField(
                                        controller: _bandCtrl,
                                        style: const TextStyle(color: Color(0xFFE8E0EE)),
                                        decoration: InputDecoration(
                                            hintText: l.authHintBands,
                                            hintStyle: const TextStyle(color: Color(0xFFAA9AB5)),
                                            filled: true,
                                            fillColor: const Color(0xFF1A0A1F),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        ),
                                        onSubmitted: (val) {
                                            final v = val.trim();
                                            if (v.isNotEmpty && !_favoriteBands.contains(v)) {
                                                setState(() => _favoriteBands.add(v));
                                                _bandCtrl.clear();
                                            }
                                        },
                                    ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                    onPressed: () {
                                        final v = _bandCtrl.text.trim();
                                        if(v.isNotEmpty && !_favoriteBands.contains(v)) {
                                            setState(() => _favoriteBands.add(v));
                                            _bandCtrl.clear();
                                        }
                                    },
                                    icon: const Icon(Icons.add_circle, color: Color(0xFF7B00D4), size: 32),
                                ),
                            ],
                        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                        if(_favoriteBands.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Wrap(
                                spacing: 8, 
                                runSpacing: 8,
                                children: _favoriteBands.map((band) => Chip(
                                    label: Text(band, style: const TextStyle(color: Colors.white)),
                                    backgroundColor: const Color(0xFF2A1A35),
                                    deleteIconColor: const Color(0xFF8b0000),
                                    onDeleted: () => setState(() => _favoriteBands.remove(band)),
                                )).toList(),
                            ),
                            const SizedBox(height: 24),
                        ],

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
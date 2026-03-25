import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/music_tags.dart';
import '../widgets/animated_step.dart';

class StepTags extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepTags({super.key, required this.onNext});

    @override
    State<StepTags> createState() => _StepTagsState();
}

class _StepTagsState extends State<StepTags> {
    List<String> _genres        = [];
    List<String> _vibes         = [];
    List<String> _aesthetics    = [];
    List<String> _intensity     = [];
    List<String> _eras          = [];
    List<String> _discovery     = [];
    String? _error;

    void _toggle(List<String> list, String tag) {
        setState(() => list.contains(tag) ? list.remove(tag) : list.add(tag));
    }

    void _next() {
        if (_genres.isEmpty || _aesthetics.isEmpty) {
            setState(() => _error = 'Sélectionne au moins un genre et une esthétique.');
            return;
        }
        widget.onNext({
            'musicGenres':          _genres,
            'musicVibes':           _vibes,
            'aesthetics':           _aesthetics,
            'soundIntensity':       _intensity,
            'musicEras':            _eras,
            'discoveryFormats':     _discovery,
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
        return AnimatedStep(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(height: 32),
                        const Text(
                            'Ton univers musical',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        const Text(
                            'Ces tags servent à te matcher avec des profils compatibles.',
                            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        _section('Genres musicaux',         kMusicGenres,       _genres,        300),
                        _section('Ambiance musicale',       kMusicVibes,        _vibes,         400),
                        _section('Esthétique',              kAesthetics,        _aesthetics,    500),
                        _section('Intensité sonore',        kSoundIntensity,    _intensity,     600),
                        _section('Époque',                  kMusicEras,         _eras,          700),
                        _section('Découverte musicale',     kDiscoveryFormats,  _discovery,     800),

                        if (_error != null) ...[
                            Text(_error!, style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13)),
                            const SizedBox(height: 12),
                        ],
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _next,
                                child: const Text('Continuer'),
                            ),
                        ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import '../widgets/animated_step.dart';

class StepPreferences extends StatefulWidget {
    final Map<String, dynamic> data;
    final void Function(Map<String, dynamic>) onNext;
    const StepPreferences({super.key, required this.data, required this.onNext});

    @override
    State<StepPreferences> createState() => _StepPreferencesState();
}

class _StepPreferencesState extends State<StepPreferences> {
    RangesValues _ageRange = const RangesValues(18, 40);
    double _maxDistance = 50;
    List<String> _genderPrefs = [];
    bool _loading = false;
    String? _error;

    static const _genders = [
        'Homme', 'Femme', 'Nom-binaire', 'Genderfluid',
        'Agenre', 'Transmasculin', 'Transféminin', 'Tous',
    ];

    void _toggleGender(String g) {
        setState(() => _genderPrefs.contains(g)
        ? _genderPrefs.remove(g)
        : _genderPrefs.add(g));
    }

    Future<void> _submit() async {
        if (_genderPrefs.isEmpty) {
            setState(() => _error = 'Sélectionne au moins une préférence.');
            return;
        }

        setState(() {_loading = true; _error = null; });

        try {
            final d = widget.data;

            await AuthService().register(
                d['email'],
                d['password'],
                d['username'],
            );

            await FirestoreService().saveProfile({
                'birthDate':            d['birthDate'],
                'gender':               d['gender'],
                'pronouns':             d['pronouns'],
                'musicGenres':          d['musicGenres']        ?? [],
                'musicVibes':           d['musicVibes']         ?? [],
                'aesthetics':           d['aesthetics']         ?? [],
                'soundIntensity':       d['soundIntensity']     ?? [],
                'musicEras':            d['musicEras']          ?? [],
                'discoveryFormats':     d['discoveryFormats']   ?? [],
                'ageMin':               _ageRange.start.round(),
                'ageMax':               _ageRange.end.round(),
                'maxDistance':          _maxDistance.round(),
                'genderPreferences':    _genderPrefs,
                'profileComplete':      true,
                if (d['location'] != null) 'location': d['location'],
            });

            if (mounted) Navigator.pushRemplacementNamed(context, '/home');
        } catch (e) {
            setState(() {_error = e.toString(); _loading = false;});
        }
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
                            'Tes préférences',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        const Text(
                            'Qui veux-tu rencontrer ?',
                            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        // TRANCHE D'ÂGE
                        Text(
                            'Tranched\'âge : ${_ageRange.start.round()} - ${_ageRange.end.round()} ans',
                            style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12,
                                letterSpacing: 1.2, fontWeight: FontWeight.bold),
                        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        RangeSlider(
                            values: _ageRange,
                            min: 18,
                            max: 99,
                            divisions: 81,
                            activeColor: const Color(0xFF7B00D4),
                            inactiveColor: const Color(0xFF2A1A35),
                            onChanged: (v) => setState(() => _ageRange = v),
                        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        const SizedBox(height: 24),

                        // DISTANCE MAX
                        Text(
                            'Distance max : ${_maxDistance.round()} km',
                            style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12,
                                letterSpacing: 1.2, fontWeight: FontWeight.bold),
                        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        Slider(
                            value: _maxDistance,
                            min: 5,
                            max: 300,
                            divisions: 59,
                            activeColor: const Color(0xFF7B00D4),
                            inactiveColor: const Color(0xFF2A1A35),
                            onChanged: (v) => setState(() => _maxDistance = v),
                        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        const SizedBox(height: 24),

                        // GENRE RECHERCHÉ
                        const Text(
                            'Genre(s) recherché(s)',
                            style: TextStyle(color: Color(0xFF7B00D4), fontSize: 12,
                                letterSpacing: 1.2, fontWeight: FontWeight.bold),
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                        const SizedBox(height: 10),
                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _genders.map((g) => FilterChip(
                                label: Text(g),
                                selected: _genderPrefs.contains(g),
                                onSelected: (_) => _toggleGender(g),
                                selectedColor: const Color(0xFF7B00D4),
                                checkmarkColor: Colors.white,
                            )).toList(),
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                        if (_error != null) ...[
                            const SizedBox(height: 16),
                            Text(_error!, style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13)),
                            ],
                        const SizedBox(height: 32),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _loading ? null : _submit,
                                child: _loading
                                    ? const SizedBox(width: 20, height: 20
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                    : const Text('Créer mon compte'),
                            ),
                        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}
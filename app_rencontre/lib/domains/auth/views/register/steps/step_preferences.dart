import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/core/gender_options.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/auth_service.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/shared/services/revenue_cat_service.dart';
import 'package:nocturne/domains/profile/services/photo_service.dart';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';
import 'package:nocturne/domains/auth/views/register/registration_success_page.dart';

class StepPreferences extends StatefulWidget {
    final Map<String, dynamic> data;
    final void Function(Map<String, dynamic>) onNext;
    const StepPreferences({super.key, required this.data, required this.onNext});

    @override
    State<StepPreferences> createState() => _StepPreferencesState();
}

class _StepPreferencesState extends State<StepPreferences> {
    RangeValues _ageRange = const RangeValues(18, 40);
    double _maxDistance = 50;
    final List<String> _genderPrefs = [];
    bool _loading = false;
    String? _error;

    void _toggleGender(String g) {
        setState(() => _genderPrefs.contains(g)
        ? _genderPrefs.remove(g)
        : _genderPrefs.add(g));
    }

    Future<void> _submit() async {
        if (_genderPrefs.isEmpty) {
            setState(() => _error = AppLocalizations.of(context)!.authErrorSelectPreference);
            return;
        }

        setState(() {_loading = true; _error = null; });

        try {
            final d = widget.data;

            final userId = await AuthService().register(
                d['email'],
                d['password'],
                d['username'],
            );
            await RevenueCatService.identify(userId);

            final photos = d['photos'] as List<String>? ?? [];
            List<String> photosUrls = [];
            if (photos.isNotEmpty) {
                photosUrls = await PhotoService.uploadPhotos(photos);
            }

            await FirestoreService().saveProfile({
                'birthDate':            d['birthDate'],
                'gender':               d['gender'],
                'pronouns':             d['pronouns'],
                'bio':                  d['bio'] ?? '',
                'musicsGenres':         d['musicGenres']        ?? [],
                'musicsVibes':          d['musicVibes']         ?? [],
                'aesthetics':           d['aesthetics']         ?? [],
                'soundIntensity':       d['soundIntensity']     ?? [],
                'musicEras':            d['musicEras']          ?? [],
                'discoveryFormats':     d['discoveryFormats']   ?? [],
                'ageMin':               _ageRange.start.round(),
                'ageMax':               _ageRange.end.round(),
                'maxDistance':          _maxDistance.round(),
                'genderPreferences':    _genderPrefs,
                'profileComplete':      true,
                if (photosUrls.isNotEmpty) 'photos': photosUrls,
                if (d['location'] != null) 'location': d['location'],
            });

            if (mounted) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const RegistrationSuccessPage(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 600),
                ),
              );
            }
        } catch (e) {
            setState(() {_error = e.toString(); _loading = false;});
        }
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
                            l.authStepPreferencesTitle,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                            l.authStepPreferencesSubtitle,
                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        // TRANCHE D'ÂGE
                        Text(
                            l.authAgeRangeLabel(_ageRange.start.round(), _ageRange.end.round()),
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
                            l.authMaxDistanceLabel(_maxDistance.round()),
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
                        Text(
                            l.authLabelGenderPreferences,
                            style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12,
                                letterSpacing: 1.2, fontWeight: FontWeight.bold),
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                        const SizedBox(height: 10),
                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: genderOptions(l, includeAll: true).map((opt) => FilterChip(
                                label: Text(opt.label),
                                selected: _genderPrefs.contains(opt.value),
                                onSelected: (_) => _toggleGender(opt.value),
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
                                    ? const SizedBox(width: 20, height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                    : Text(l.authBtnCreateAccount),
                            ),
                        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}
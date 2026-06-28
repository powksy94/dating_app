import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';

class StepLocation extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepLocation({super.key, required this.onNext});
    
    @override
    State<StepLocation> createState() => _StepLocationState();
}

class _StepLocationState extends State<StepLocation> {
    bool _loading = false;
    Position? _position;
    String? _error;

    Future<void> _requestLocation() async {
        final l = AppLocalizations.of(context)!;
        setState(() { _loading = true; _error = null; });

        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
            setState(() {
                _error = l.authLocationPermissionDenied;
                _loading = false;
            });
            return;
        }

        try {
            final pos = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.medium,
            ).timeout(const Duration(seconds: 10));
            setState(() { _position = pos; _loading = false; });
        } catch (_) {
            setState(() {
                _error = l.authLocationError;
                _loading = false;
            });
        }
    }

    void _next() {
        if (_position != null) {
            widget.onNext({
                'location': {
                    'type': 'Point',
                    'coordinates': [_position!.longitude, _position!.latitude],
                },
            });
        } else {
            widget.onNext({});
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
                            l.authStepLocationTitle,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                            l.authStepLocationSubtitle,
                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 48),

                        if (_position != null)
                            Center(
                                child: Column(
                                    children: [
                                        const Icon(Icons.location_on, color: Color(0xFF7B00D4), size: 64),
                                        const SizedBox(height: 12),
                                        Text(
                                            '${_position!.latitude.toStringAsFixed(4)}, ${_position!.longitude.toStringAsFixed(4)}',
                                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            l.authLocationSaved,
                                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                    ],
                                ),
                            ).animate().fadeIn(duration: 400.ms)
                        else
                            Center(
                                child: Column(
                                    children: [
                                        const Icon(Icons.location_off, color: Color(0xFFAA9AB5), size: 64),
                                        const SizedBox(height: 16),
                                        if (_error != null)
                                            Text(
                                                _error!,
                                                style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13),
                                                textAlign: TextAlign.center,
                                            ),
                                    ],
                                ),
                            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

                        const SizedBox(height: 48),

                        if (_position == null)
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                    onPressed: _loading ? null : _requestLocation,
                                    icon: _loading
                                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                        : const Icon(Icons.my_location),
                                    label: Text(l.authBtnAllowLocation),
                                ),
                            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        const SizedBox(height: 12),
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: _next,
                                child: Text(
                                    _position != null ? l.authBtnContinue : l.authBtnSkipStep,
                                    style: const TextStyle(color: Color(0xFFAA9AB5)),
                                ),
                            ),
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}
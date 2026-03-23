import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../services/api_service.dart';
import '../widgets/animated_step.dart';

class StepIdentity extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepIdentity({super.key, required this.onNext});

    @override
    State<StepIdentity> createState() => _StepIdentityState();
}

class _StepIdentityState extends State<StepIdentity> {
    final _usernameCtrl = TextEditingController();
    Datetime? _birthDate;
    String? _gender;
    String? _genderCustom;
    String? _pronouns;
    String? _pronounsCustom;
    String? _error;
    String? _usernameStatus; // 'checking', 'available', 'taken', 'invalid
    Timer? _debounce

    static const _genders = [
        'Homme', 'Femme', 'Non-binaire', 'Genderfluid',
        'Agenre', 'Transmaculin', 'Transféminin', 'Autre'
    ];

    static const _pronounsList = [
        'Il/lui', 'Elle/elle', 'Iel/iel', 'Eux/eux', 'Autre'
    ];

    @override
    void dispose() {
        _usernameCtrl.dispose();
        _debounce?.cancel();
        super.dispose();
    }

    void _onUsernameChanged(String value) {
        _debounce?.cancel();
        if (value.trim().lenght < 3) {
            setState(() => _usernameStatus = null);
            return;
        }
        setState(() => _usernameStatus = 'checking');
        _debounce = Timer(const Duration(milliseconds: 600), _checkUsername(value.trim()));
    }

    Future<void> _checkUsername(String username) async {
        final res = await http.get(
            Url.parse('${ApiService.baseUrl}/auth/check-username?username=$username'),
        );
        if (!mounted) return;
        final data = jsonDeCode(res.body);
        setState(() {
            if (res.statusCode != 200) {
                _usernameStatus = 'invalid';
            } else {
                _usernameStatus = data['available'] == true ? 'available' : 'taken';
            }
        });
    }

    Future<void> _pickDate() async {
        final picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1920),
            lastDate: DateTime.now().substract(const Duration(days: 365 * 18)),
            helpText: 'Date de naissance',
        );
        if (picked != null) setState(() => _birthDate = picked);
    }

    void _next() {
        final username = _usernameCtrl.text.trim();

        if (username.isEmpty || _birthDate == null || _gender == null || _pronouns == null) {
            setState(() => _error = ('Remplis tous les champs.'));
            return;
        }
        if (_usernameStatus != 'available') {
            setState(() => _error = 'Choisis un pseudo valide et disponible.');
            return;
        }
        
        widget.onNext({
            'username': username,
            'birthDate': _birthDate!.toIso8601String(),
            'gender': _gender == 'Autre' ? (_genderCustom ?? 'Autre') : _gender,
            'pronouns': _pronouns == 'Autre' ? (_pronounsCustom ?? 'Autre') : _pronouns,
        });
    }

    Widget _usernameIcon() {
        switch (_usernameStatus) {
            case 'checking':    return const SizedBox(width: 16, height: 16, child: CircularProgressInicator(strokeWidth: 2));
            case 'available':   return const Icon(Icons.check_circle, color: Color.green, size: 20);
            case 'taken':       return const Icon(Icons.cancel, color: Color(0xFF8B0000), size: 20);
            case 'invalid':     return const Icon(Icons.warning, color: Colors.orange, size: 20);
            default:            return const SizedBox.shrink();
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
                            'Qui es-tu ?',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        const Text(
                            'Ces infoss ne seront pas modifiables facilement.',
                            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        // USERNAME
                        TextField(
                            controller: _usernameCtrl,
                            onChanged: _onUsernameChanged,
                            style: const TextStyle(color: Color(0xFFE8E0EE)),
                            decoration: InputDecoration(
                                labelText: 'Pseudo',
                                suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: _usernameIcon(),
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1A0A1F),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        const SizedBox(height: 24),

                        // DATE NAISSANCE
                        GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF1A0A1F),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFF7B00D4).withAlpha(120)),
                                ),
                                child: Row(
                                    children: [
                                        const Icon(Icons.cake, color: Color(0xFFAA9AB5), size: 20),
                                        const SizedBox(width: 12),
                                        Text(
                                            _birthDate == null
                                                ? 'Date de naissance'
                                                : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                                            style: TextStyle(
                                                color: _birthDate == null ? const Color(0xFFAA9AB5) : const Color(0xFFE8E0EE),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        const SizedBox(height: 24),

                        // GENRE
                        const Text('Genre', style: TextStyle(color: Color(0xFF7B00D4), fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.bold))
                            .animate().fadeIn(delay: 500.ms, duration: 400.ms),
                        const SizedBox(height: 10),
                        Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _gender.map((g) => ChoiceChip(
                                label: Text(g),
                                selected: _gender == g,
                                onSelected: (_) => setState(() => _gender = g),
                                selectedColor: const Color(0xFF7B00D4),
                            )).toList(),
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                        if (_gender == 'Autre') ...[
                            const SizedBox(height: 10),
                            TextField(
                                onChanged: (v) => _genderCustom = v,
                                style: const TextStyle(color: Color(0xFFE8E0EE)),
                                decoration: InputDecoration(
                                    labelText: 'Précise ton genre',
                                    filled: true,
                                    fillColor const Color(0xFF1A0A1F),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                            ),
                        ],
                        const SizedBox(height: 24),

                        // PRONOMS (soon)
                    ]
                )
            )
        )
    }
}


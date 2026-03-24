import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_step.dart';
import '../widgets/username_field.dart';
import '../widgets/chip_selector.dart';

class StepIdentity extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepIdentity({super.key, required this.onNext});

    @override
    State<StepIdentity> createState() => _StepIdentityState();
}

class _StepIdentityState extends State<StepIdentity> {
    final _usernameCtrl = TextEditingController();
    DateTime? _birthDate;
    String? _gender;
    String? _genderCustom;
    String? _pronouns;
    String? _pronounsCustom;
    String? _error;
    String? _usernameStatus;

    static const _genders = [
        'Homme', 'Femme', 'Non-binaire', 'Genderfluid',
        'Agenre', 'Transmasculin', 'Transféminin', 'Autre',
    ];

    static const _pronounsList = [
        'Il/lui', 'Elle/elle', 'Iel/iel', 'Eux/eux', 'Autre',
    ];

    @override
    void dispose() {
        _usernameCtrl.dispose();
        super.dispose();
    }

    Future<void> _pickDate() async {
        final picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1920),
            lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
            helpText: 'Date de naissance',
        );
        if (picked != null) setState(() => _birthDate = picked);
    }

    void _next() {
        final username = _usernameCtrl.text.trim();
        if (username.isEmpty || _birthDate == null || _gender == null || _pronouns == null) {
            setState(() => _error = 'Remplis tous les champs.');
            return;
        }
        if (_usernameStatus != 'available') {
            setState(() => _error = 'Choisis un pseudo valide et disponible.');
            return;
        }
        widget.onNext({
            'username':  username,
            'birthDate': _birthDate!.toIso8601String(),
            'gender':    _gender == 'Autre' ? (_genderCustom ?? 'Autre') : _gender,
            'pronouns':  _pronouns == 'Autre' ? (_pronounsCustom ?? 'Autre') : _pronouns,
        });
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
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFE8E0EE)),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        const Text(
                            'Ces infos ne seront pas modifiables facilement.',
                            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        UsernameField(
                            controller: _usernameCtrl,
                            onStatusChanged: (s) => setState(() => _usernameStatus = s),
                        ),
                        const SizedBox(height: 24),

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

                        ChipSelector(
                            title: 'Genre',
                            options: _genders,
                            selected: _gender,
                            onSelected: (v) => setState(() => _gender = v),
                            onCustomChanged: (v) => _genderCustom = v,
                            fadeDelayMs: 500,
                        ),
                        const SizedBox(height: 24),

                        ChipSelector(
                            title: 'Pronoms',
                            options: _pronounsList,
                            selected: _pronouns,
                            onSelected: (v) => setState(() => _pronouns = v),
                            onCustomChanged: (v) => _pronounsCustom = v,
                            fadeDelayMs: 600,
                        ),

                        if (_error != null) ...[
                            const SizedBox(height: 12),
                            Text(_error!, style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13)),
                        ],
                        const SizedBox(height: 32),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _next,
                                child: const Text('Continuer'),
                            ),
                        ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}

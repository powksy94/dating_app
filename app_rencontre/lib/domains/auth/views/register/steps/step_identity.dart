import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/core/gender_options.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';
import 'package:nocturne/domains/auth/widgets/username_field.dart';
import 'package:nocturne/domains/auth/widgets/chip_selector.dart';

class StepIdentity extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepIdentity({super.key, required this.onNext});

    @override
    State<StepIdentity> createState() => _StepIdentityState();
}

class _StepIdentityState extends State<StepIdentity> {
    final _usernameCtrl = TextEditingController();
    final _bioCtrl = TextEditingController();
    DateTime? _birthDate;
    String? _gender;
    String? _genderCustom;
    String? _pronouns;
    String? _pronounsCustom;
    String? _error;
    String? _usernameStatus;

    @override
    void dispose() {
        _usernameCtrl.dispose();
        _bioCtrl.dispose();
        super.dispose();
    }

    Future<void> _pickDate() async {
        final l = AppLocalizations.of(context)!;
        final picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1920),
            lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
            helpText: l.authLabelBirthDate,
        );
        if (picked != null) setState(() => _birthDate = picked);
    }

    void _next() {
        final l = AppLocalizations.of(context)!;
        final username = _usernameCtrl.text.trim();
        if (username.isEmpty || _birthDate == null || _gender == null || _pronouns == null) {
            setState(() => _error = l.authErrorFillAllFields);
            return;
        }
        if (_usernameStatus != 'available') {
            setState(() => _error = l.authErrorUsernameInvalid);
            return;
        }
        widget.onNext({
            'username':  username,
            'birthDate': _birthDate!.toIso8601String(),
            'gender':    _gender == 'other' ? (_genderCustom ?? 'other') : _gender,
            'pronouns':  _pronouns == 'other' ? (_pronounsCustom ?? 'other') : _pronouns,
            'bio':       _bioCtrl.text.trim(),
        });
    }

    @override
    Widget build(BuildContext context) {
        final l = AppLocalizations.of(context)!;
        return AnimatedStep(
            child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(28, 0, 28, MediaQuery.viewInsetsOf(context).bottom + 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(height: 32),
                        Text(
                            l.authStepIdentityTitle,
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFE8E0EE)),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                            l.authStepIdentitySubtitle,
                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
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
                                                ? l.authLabelBirthDate
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
                            title: l.authLabelGender,
                            options: genderOptions(l),
                            selected: _gender,
                            onSelected: (v) => setState(() => _gender = v),
                            onCustomChanged: (v) => _genderCustom = v,
                            fadeDelayMs: 500,
                        ),
                        const SizedBox(height: 24),

                        ChipSelector(
                            title: l.authLabelPronouns,
                            options: pronounOptions(l),
                            selected: _pronouns,
                            onSelected: (v) => setState(() => _pronouns = v),
                            onCustomChanged: (v) => _pronounsCustom = v,
                            fadeDelayMs: 600,
                        ),
                        const SizedBox(height: 24),

                        Text(
                            l.authLabelBio,
                            style: const TextStyle(
                                color: Color(0xFF7B00D4), fontSize: 12,
                                letterSpacing: 1.2, fontWeight: FontWeight.bold,
                            ),
                        ).animate().fadeIn(delay: 650.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        ValueListenableBuilder(
                            valueListenable: _bioCtrl,
                            builder: (context, value, _) {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                        TextField(
                                            controller: _bioCtrl,
                                            maxLines: 4,
                                            maxLength: 700,
                                            buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                                            style: const TextStyle(color: Color(0xFFE8E0EE)),
                                            decoration: InputDecoration(
                                                hintText: l.authHintBio,
                                                hintStyle: const TextStyle(color: Color(0xFFAA9AB5)),
                                                filled: true,
                                                fillColor: const Color(0xFF1A0A1F),
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                            ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            '${value.text.length}/700',
                                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 12),
                                        ),
                                    ],
                                );
                            },
                        ).animate().fadeIn(delay: 650.ms, duration: 400.ms),

                        if (_error != null) ...[
                            const SizedBox(height: 12),
                            Text(_error!, style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13)),
                        ],
                        const SizedBox(height: 32),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _next,
                                child: Text(l.authBtnContinue),
                            ),
                        ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}

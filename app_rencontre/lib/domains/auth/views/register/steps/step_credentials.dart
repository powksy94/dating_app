import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';

class StepCredentials extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepCredentials({super.key, required this.onNext});

    @override
    State<StepCredentials> createState() => _StepCredentialsState();
}

class _StepCredentialsState extends State<StepCredentials> {
    final _emailCtrl    = TextEditingController();
    final _passCtrl     = TextEditingController();
    final _confirmCtrl  = TextEditingController();
    String? _error;

    @override
    void dispose() {
        _emailCtrl.dispose();
        _passCtrl.dispose();
        _confirmCtrl.dispose();
        super.dispose();
    }

    void _next() {
        final l = AppLocalizations.of(context)!;
        final email     = _emailCtrl.text.trim();
        final password  = _passCtrl.text;
        final confirm   = _confirmCtrl.text;

        if (email.isEmpty || password.isEmpty) {
            setState(()  => _error = l.authErrorFillAllFields);
            return;
        }
        if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email)) {
            setState(() => _error = l.authErrorInvalidEmail);
            return;
        }
        if (password.length < 12) {
            setState(() => _error = l.authErrorPasswordTooShort);
            return;
        }
        if (password != confirm) {
            setState(() => _error = l.authErrorPasswordMismatch);
            return;
        }

        widget.onNext({'email': email, 'password': password});
    }

    @override
    Widget build(BuildContext context) {
        final l = AppLocalizations.of(context)!;
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return AnimatedStep(
            child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(28, 0, 28, bottomInset + 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(height: 32),
                        Text(
                            l.authStepCredentialsTitle,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                                height: 1.3,
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                            l.authStepCredentialsSubtitle,
                            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        const SizedBox(height: 40),
                        _Field(
                            ctrl: _emailCtrl,
                            label: l.authLabelEmail,
                            keyboardType: TextInputType.emailAddress,
                        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        const SizedBox(height: 16),
                        _Field(
                            ctrl: _passCtrl,
                            label: l.authLabelPassword,
                            obscure: true,
                            helper: l.authHelperPasswordMin,
                        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        const SizedBox(height: 16),
                        _Field(
                            ctrl: _confirmCtrl,
                            label: l.authLabelConfirmPassword,
                            obscure: true,
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                        if (_error != null) ...[
                            const SizedBox(height: 12),
                            Text(
                                _error!,
                                style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13),
                            ),
                        ],
                        const SizedBox(height: 32),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _next,
                                child: Text(l.authBtnContinue),
                            ),
                        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                    ],
                ),
            ),
        );
    }
}

class _Field extends StatelessWidget {
    final TextEditingController ctrl;
    final String label;
    final bool obscure;
    final String? helper;
    final TextInputType? keyboardType;

    const _Field({
        required this.ctrl,
        required this.label,
        this.obscure = false,
        this.helper,
        this.keyboardType,
    });

    @override
    Widget build(BuildContext context) {
        return TextField(
            controller: ctrl,
            obscureText: obscure,
            keyboardType: keyboardType,
            style: const TextStyle(color: Color(0xFFE8E0EE)),
            decoration: InputDecoration(
                labelText: label, 
                helperText: helper,
                helperStyle: const TextStyle(color: Color(0xFFAA9AB5)),
                filled: true, 
                fillColor: const Color(0xFF1A0A1F),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF7B00D4)),
                ),
            ),
        );
    }
}
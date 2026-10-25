import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/auth_service.dart';

/// First step: the user enters their email and requests a reset code.
/// Owns its own form/loading/error state; only tells the parent once a code
/// has actually been requested successfully.
class StepForgotEmail extends StatefulWidget {
  final void Function(String email) onSent;
  const StepForgotEmail({super.key, required this.onSent});

  @override
  State<StepForgotEmail> createState() => _StepForgotEmailState();
}

class _StepForgotEmailState extends State<StepForgotEmail> {
  final _auth = AuthService();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context)!;
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      setState(() => _error = l.authErrorFillAllFields);
      return;
    }
    if (!email.contains('@')) {
      setState(() => _error = l.authErrorInvalidEmail);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });
    final err = await _auth.forgotPassword(email, unknownError: l.commonUnknownError);
    if (!mounted) return;
    if (err == null) {
      widget.onSent(email);
    } else {
      setState(() {
        _loading = false;
        _error = err;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.authForgotSubtitle, style: const TextStyle(color: Color(0xFFAA9AB5))),
        const SizedBox(height: 24),
        TextField(
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(labelText: l.authLabelEmail),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(_error!, style: const TextStyle(color: Color(0xFF8B0000))),
        ],
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _loading ? null : _submit,
          child: _loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : Text(l.authBtnSendCode),
        ),
      ],
    );
  }
}

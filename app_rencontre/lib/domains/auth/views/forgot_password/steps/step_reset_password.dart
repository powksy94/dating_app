import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/password_reset_service.dart';
import 'package:nocturne/domains/auth/widgets/password_field.dart';

/// Final step: the code was already verified by step_verify_code.dart, so
/// this step only collects the new password. Owns its own form/loading/error
/// state; only tells the parent once the reset has actually succeeded.
class StepResetPassword extends StatefulWidget {
  final String email;
  final String code;
  final VoidCallback onDone;
  const StepResetPassword({
    super.key,
    required this.email,
    required this.code,
    required this.onDone,
  });

  @override
  State<StepResetPassword> createState() => _StepResetPasswordState();
}

class _StepResetPasswordState extends State<StepResetPassword> {
  final _auth = PasswordResetService();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context)!;
    final next = _newCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (next.isEmpty || confirm.isEmpty) {
      setState(() => _error = l.authErrorFillAllFields);
      return;
    }
    if (next != confirm) {
      setState(() => _error = l.authErrorPasswordMismatch);
      return;
    }
    if (next.length < 12) {
      setState(() => _error = l.authErrorPasswordTooShort);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final err = await _auth.resetPassword(
        widget.email, widget.code, next,
        unknownError: l.commonUnknownError,
      );
      if (!mounted) return;
      if (err == null) {
        widget.onDone();
        return;
      }
      setState(() => _error = err);
    } on TimeoutException {
      if (mounted) setState(() => _error = l.commonLoadErrorSubtitle);
    } catch (_) {
      if (mounted) setState(() => _error = l.commonUnknownError);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.authResetSubtitle, style: const TextStyle(color: Color(0xFFAA9AB5))),
        const SizedBox(height: 24),
        PasswordField(controller: _newCtrl, label: l.authLabelNewPassword),
        const SizedBox(height: 12),
        PasswordField(controller: _confirmCtrl, label: l.authLabelConfirmPassword),
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
              : Text(l.authBtnResetPassword),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/auth_service.dart';
import 'package:nocturne/domains/auth/widgets/password_field.dart';

/// Second step: the user enters the emailed 6-digit code plus a new password.
/// Owns its own form/loading/error state; only tells the parent once the
/// reset has actually succeeded.
class StepResetPassword extends StatefulWidget {
  final String email;
  final String? infoMessage;
  final VoidCallback onDone;
  const StepResetPassword({
    super.key,
    required this.email,
    required this.onDone,
    this.infoMessage,
  });

  @override
  State<StepResetPassword> createState() => _StepResetPasswordState();
}

class _StepResetPasswordState extends State<StepResetPassword> {
  final _auth = AuthService();
  final _codeCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _codeCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context)!;
    final code = _codeCtrl.text.trim();
    final next = _newCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (code.isEmpty || next.isEmpty || confirm.isEmpty) {
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
    final err = await _auth.resetPassword(
      widget.email, code, next,
      unknownError: l.commonUnknownError,
    );
    if (!mounted) return;
    if (err == null) {
      widget.onDone();
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
        if (widget.infoMessage != null) ...[
          Text(widget.infoMessage!, style: const TextStyle(color: Color(0xFFAA9AB5))),
          const SizedBox(height: 12),
        ],
        Text(l.authResetSubtitle, style: const TextStyle(color: Color(0xFFAA9AB5))),
        const SizedBox(height: 24),
        TextField(
          controller: _codeCtrl,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(labelText: l.authLabelResetCode),
        ),
        const SizedBox(height: 12),
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

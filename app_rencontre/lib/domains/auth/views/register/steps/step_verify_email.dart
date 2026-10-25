import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/email_verification_service.dart';

/// Mandatory gate right after register(): the rest of the profile (photos,
/// preferences) is only saved once the emailed 6-digit code is verified.
/// Owns its own form/loading/error state, plus a resend action.
class StepVerifyEmail extends StatefulWidget {
  final String email;
  final Future<void> Function() onVerified;
  const StepVerifyEmail({super.key, required this.email, required this.onVerified});

  @override
  State<StepVerifyEmail> createState() => _StepVerifyEmailState();
}

class _StepVerifyEmailState extends State<StepVerifyEmail> {
  final _service = EmailVerificationService();
  final _codeCtrl = TextEditingController();
  bool _loading = false;
  bool _resending = false;
  String? _error;
  String? _info;

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context)!;
    final code = _codeCtrl.text.trim();
    if (code.isEmpty) {
      setState(() => _error = l.authErrorFillAllFields);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _info = null;
    });
    try {
      final err = await _service.verifyEmail(code, unknownError: l.commonUnknownError);
      if (!mounted) return;
      if (err != null) {
        setState(() {
          _error = err;
          _loading = false;
        });
        return;
      }
      // Stays "loading" through the rest of registration (photo upload,
      // profile save, navigation) that onVerified runs.
      await widget.onVerified();
    } on TimeoutException {
      if (mounted) {
        setState(() {
          _error = l.commonLoadErrorSubtitle;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _resend() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _resending = true;
      _error = null;
      _info = null;
    });
    try {
      final err = await _service.resendVerificationCode(unknownError: l.commonUnknownError);
      if (!mounted) return;
      setState(() {
        if (err == null) {
          _info = l.authVerifyEmailResentMessage;
        } else {
          _error = err;
        }
      });
    } catch (_) {
      if (mounted) setState(() => _error = l.commonUnknownError);
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.authStepVerifyEmailTitle,
            style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFE8E0EE))),
        const SizedBox(height: 8),
        Text(l.authStepVerifyEmailSubtitle(widget.email),
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14)),
        const SizedBox(height: 24),
        if (_info != null) ...[
          Text(_info!, style: const TextStyle(color: Color(0xFFAA9AB5))),
          const SizedBox(height: 12),
        ],
        TextField(
          controller: _codeCtrl,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(labelText: l.authLabelVerificationCode),
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
              : Text(l.authBtnVerifyEmail),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: _resending ? null : _resend,
          child: _resending
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l.authBtnResendVerificationCode,
                  style: const TextStyle(color: Color(0xFFAA9AB5))),
        ),
      ],
    );
  }
}

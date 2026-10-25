import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/auth_service.dart';

/// Middle step: the user enters the emailed 6-digit code and it's checked
/// immediately (without being consumed yet) before moving on to the new
/// password step. Owns its own form/loading/error state.
class StepVerifyCode extends StatefulWidget {
  final String email;
  final String? infoMessage;
  final void Function(String code) onVerified;
  const StepVerifyCode({
    super.key,
    required this.email,
    required this.onVerified,
    this.infoMessage,
  });

  @override
  State<StepVerifyCode> createState() => _StepVerifyCodeState();
}

class _StepVerifyCodeState extends State<StepVerifyCode> {
  final _auth = AuthService();
  final _codeCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

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
    });
    try {
      final err = await _auth.verifyResetCode(widget.email, code, unknownError: l.commonUnknownError);
      if (!mounted) return;
      if (err == null) {
        widget.onVerified(code);
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
        if (widget.infoMessage != null) ...[
          Text(widget.infoMessage!, style: const TextStyle(color: Color(0xFFAA9AB5))),
          const SizedBox(height: 12),
        ],
        Text(l.authVerifyCodeSubtitle, style: const TextStyle(color: Color(0xFFAA9AB5))),
        const SizedBox(height: 24),
        TextField(
          controller: _codeCtrl,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(labelText: l.authLabelResetCode),
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
              : Text(l.authBtnVerifyCode),
        ),
      ],
    );
  }
}

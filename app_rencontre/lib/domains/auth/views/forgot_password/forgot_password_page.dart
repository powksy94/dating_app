import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/views/forgot_password/steps/step_forgot_email.dart';
import 'package:nocturne/domains/auth/views/forgot_password/steps/step_verify_code.dart';
import 'package:nocturne/domains/auth/views/forgot_password/steps/step_reset_password.dart';

enum _Step { email, verify, reset }

/// Three-step forgot-password flow, pushed on top of LoginPage: email step
/// requests a code, verify step checks it on its own, reset step consumes it
/// for a new password. Each step owns its own form and API call (see
/// step_forgot_email.dart/step_verify_code.dart/step_reset_password.dart);
/// this page only tracks which step is showing and the email/code carried
/// between them.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  _Step _step = _Step.email;
  String _email = '';
  String _code = '';

  void _onCodeSent(String email) {
    setState(() {
      _email = email;
      _step = _Step.verify;
    });
  }

  void _onCodeVerified(String code) {
    setState(() {
      _code = code;
      _step = _Step.reset;
    });
  }

  void _onResetDone() {
    final l = AppLocalizations.of(context)!;
    // Login is directly beneath this page on the stack: a plain pop lands
    // back on it, no need for popUntil/named-route gymnastics.
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.authResetSuccessMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(_title(l))),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: _body(l),
        ),
      ),
    );
  }

  String _title(AppLocalizations l) => switch (_step) {
        _Step.email => l.authForgotTitle,
        _Step.verify => l.authVerifyCodeTitle,
        _Step.reset => l.authResetTitle,
      };

  Widget _body(AppLocalizations l) => switch (_step) {
        _Step.email => StepForgotEmail(onSent: _onCodeSent),
        _Step.verify => StepVerifyCode(
            email: _email,
            infoMessage: l.authForgotSentMessage,
            onVerified: _onCodeVerified,
          ),
        _Step.reset => StepResetPassword(
            email: _email,
            code: _code,
            onDone: _onResetDone,
          ),
      };
}

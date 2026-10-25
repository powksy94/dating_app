import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/views/forgot_password/steps/step_forgot_email.dart';
import 'package:nocturne/domains/auth/views/forgot_password/steps/step_reset_password.dart';

enum _Step { email, reset }

/// Two-step forgot-password flow, pushed on top of LoginPage: email step
/// requests a code, reset step consumes it. Each step owns its own form and
/// API call (see step_forgot_email.dart/step_reset_password.dart); this page
/// only tracks which step is showing and the email carried between them.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  _Step _step = _Step.email;
  String _email = '';

  void _onCodeSent(String email) {
    setState(() {
      _email = email;
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
      appBar: AppBar(
        title: Text(_step == _Step.email ? l.authForgotTitle : l.authResetTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: _step == _Step.email
              ? StepForgotEmail(onSent: _onCodeSent)
              : StepResetPassword(
                  email: _email,
                  infoMessage: l.authForgotSentMessage,
                  onDone: _onResetDone,
                ),
        ),
      ),
    );
  }
}

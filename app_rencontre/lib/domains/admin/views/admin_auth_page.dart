import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/services/api_service.dart';

class AdminAuthPage extends StatefulWidget {
  final String sessionId;
  const AdminAuthPage({super.key, required this.sessionId});

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  final _localAuth = LocalAuthentication();
  bool _loading = false;
  String? _error;

  Future<void> _approve() async {
    final l = AppLocalizations.of(context)!;
    setState(() { _loading = true; _error = null; });

    try {
      final canCheck  = await _localAuth.canCheckBiometrics;
      final supported = await _localAuth.isDeviceSupported();

      if (!canCheck && !supported) {
        setState(() { _loading = false; _error = l.adminAuthErrorBiometricUnavailable; });
        return;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: l.adminAuthLocalizedReason,
        options: const AuthenticationOptions(
          stickyAuth:    true,
          biometricOnly: false,
        ),
      );

      if (!authenticated) {
        setState(() { _loading = false; _error = l.adminAuthErrorBiometricFailed; });
        return;
      }
    } catch (_) {
      setState(() { _loading = false; _error = l.adminAuthErrorBiometricGeneric; });
      return;
    }

    await _respond(true);
  }

  Future<void> _respond(bool approved) async {
    setState(() => _loading = true);
    try {
      final headers = await ApiService.authHeaders();
      await http.post(
        Uri.parse('${ApiService.baseUrl}/admin-auth/respond'),
        headers: headers,
        body: jsonEncode({'sessionId': widget.sessionId, 'approved': approved}),
      );
    } catch (_) {}
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  64,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B0099), Color(0xFF9D2FE8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7B00D4).withValues(alpha: 0.5),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context)!.adminAuthTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.adminAuthDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFAA9AB5),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fingerprint, color: Color(0xFF7B00D4), size: 16),
                  const SizedBox(width: 6),
                  Text(
                    AppLocalizations.of(context)!.adminAuthBiometricRequired,
                    style: const TextStyle(color: Color(0xFF7B00D4), fontSize: 12),
                  ),
                ],
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF450A0A),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF7F1D1D)),
                  ),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13),
                  ),
                ),
              ],
              const SizedBox(height: 40),
              if (_loading)
                const CircularProgressIndicator(color: Color(0xFF7B00D4))
              else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _approve,
                    icon: const Icon(Icons.fingerprint),
                    label: Text(AppLocalizations.of(context)!.adminAuthBtnApprove),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B00D4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _respond(false),
                    icon: const Icon(Icons.cancel_outlined),
                    label: Text(AppLocalizations.of(context)!.adminAuthBtnDeny),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFF7F1D1D)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ],
            ),
          ),
        ),
      ),
    );
  }
}

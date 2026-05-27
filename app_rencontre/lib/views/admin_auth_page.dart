import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import '../services/api_service.dart';

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
    setState(() { _loading = true; _error = null; });

    try {
      final canCheck  = await _localAuth.canCheckBiometrics;
      final supported = await _localAuth.isDeviceSupported();

      if (!canCheck && !supported) {
        setState(() { _loading = false; _error = 'Biométrie non disponible sur cet appareil'; });
        return;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Vérifiez votre identité pour approuver la connexion admin',
        options: const AuthenticationOptions(
          stickyAuth:    true,
          biometricOnly: false,
        ),
      );

      if (!authenticated) {
        setState(() { _loading = false; _error = 'Vérification biométrique échouée'; });
        return;
      }
    } catch (_) {
      setState(() { _loading = false; _error = 'Erreur biométrique'; });
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
              const Text(
                'CONNEXION ADMIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Une demande de connexion au panel admin a été initiée depuis un navigateur.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAA9AB5),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fingerprint, color: Color(0xFF7B00D4), size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Biométrie requise pour approuver',
                    style: TextStyle(color: Color(0xFF7B00D4), fontSize: 12),
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
                    label: const Text('Approuver'),
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
                    label: const Text('Refuser'),
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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import 'sections/notifications_section.dart';
import 'sections/discovery_section.dart';
import 'sections/privacy_section.dart';
import 'sections/account_section.dart';
import 'sections/about_section.dart';

// ── Dialog changement de mot de passe ─────────────────────────────────────────

class _ChangePasswordDialog extends StatefulWidget {
  final TextEditingController currentCtrl;
  final TextEditingController newCtrl;
  final TextEditingController confirmCtrl;

  const _ChangePasswordDialog({
    required this.currentCtrl,
    required this.newCtrl,
    required this.confirmCtrl,
  });

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    final current = widget.currentCtrl.text.trim();
    final next    = widget.newCtrl.text.trim();
    final confirm = widget.confirmCtrl.text.trim();

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      setState(() => _error = 'Tous les champs sont requis');
      return;
    }
    if (next != confirm) {
      setState(() => _error = 'Les mots de passe ne correspondent pas');
      return;
    }
    if (next.length < 12) {
      setState(() => _error = 'Minimum 12 caractères');
      return;
    }

    setState(() { _loading = true; _error = null; });
    final err = await AuthService().changePassword(current, next);
    if (!mounted) return;

    if (err == null) {
      await AuthService().logout();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    } else {
      setState(() { _loading = false; _error = err; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1A0A1F),
      title: const Text('Changer le mot de passe',
          style: TextStyle(color: Colors.white, fontSize: 16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PasswordField(
            controller: widget.currentCtrl,
            label: 'Mot de passe actuel',
          ),
          const SizedBox(height: 12),
          _PasswordField(
            controller: widget.newCtrl,
            label: 'Nouveau mot de passe',
          ),
          const SizedBox(height: 12),
          _PasswordField(
            controller: widget.confirmCtrl,
            label: 'Confirmer le nouveau',
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!,
                style: const TextStyle(
                    color: Color(0xFFD400FF), fontSize: 12)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('Annuler',
              style: TextStyle(color: Color(0xFF5A4A6A))),
        ),
        TextButton(
          onPressed: _loading ? null : _submit,
          child: _loading
              ? const SizedBox(
                  width: 16, height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Color(0xFF7B00D4)))
              : const Text('Confirmer',
                  style: TextStyle(color: Color(0xFF7B00D4))),
        ),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  const _PasswordField({required this.controller, required this.label});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0D0010),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: const Color(0xFF5A4A6A),
            size: 18,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF3D2A4A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7B00D4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF3D2A4A)),
        ),
      ),
    );
  }
}


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifMatches   = true;
  bool _notifMessages  = true;
  bool _notifElegies   = true;
  bool _profileVisible = true;
  double _maxDistance  = 50;
  RangeValues _ageRange = const RangeValues(18, 45);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _notifMatches    = prefs.getBool('notif_matches')    ?? true;
      _notifMessages   = prefs.getBool('notif_messages')   ?? true;
      _notifElegies    = prefs.getBool('notif_elegies')    ?? true;
      _profileVisible  = prefs.getBool('profile_visible')  ?? true;
      _maxDistance     = prefs.getDouble('max_distance')   ?? 50;
      _ageRange = RangeValues(
        prefs.getDouble('age_min') ?? 18,
        prefs.getDouble('age_max') ?? 45,
      );
      _loading = false;
    });
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  void _showChangePasswordDialog() {
    final currentCtrl = TextEditingController();
    final newCtrl     = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => _ChangePasswordDialog(
        currentCtrl: currentCtrl,
        newCtrl:     newCtrl,
        confirmCtrl: confirmCtrl,
      ),
    ).whenComplete(() {
      currentCtrl.dispose();
      newCtrl.dispose();
      confirmCtrl.dispose();
    });
  }

  Future<void> _logout() async {
    await AuthService().logout();
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A0A1F),
        title: const Text('Supprimer le compte',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Cette action est irréversible. Ton profil, tes matchs et tes élégies seront supprimés.',
          style: TextStyle(color: Color(0xFFAA9AB5)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(color: Color(0xFF7B00D4))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await AuthService().logout();
              if (mounted) Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Supprimer',
                style: TextStyle(color: Color(0xFF8B0000))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'PARAMÈTRES',
          style: TextStyle(
              fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                NotificationsSection(
                  notifMatches: _notifMatches,
                  notifMessages: _notifMessages,
                  notifElegies: _notifElegies,
                  onMatchesChanged: (v) {
                    setState(() => _notifMatches = v);
                    _saveBool('notif_matches', v);
                  },
                  onMessagesChanged: (v) {
                    setState(() => _notifMessages = v);
                    _saveBool('notif_messages', v);
                  },
                  onElegiesChanged: (v) {
                    setState(() => _notifElegies = v);
                    _saveBool('notif_elegies', v);
                  },
                ),
                DiscoverySection(
                  maxDistance: _maxDistance,
                  ageRange: _ageRange,
                  onDistanceChanged: (v) {
                    setState(() => _maxDistance = v);
                    _saveDouble('max_distance', v);
                  },
                  onAgeRangeChanged: (v) {
                    setState(() => _ageRange = v);
                    _saveDouble('age_min', v.start);
                    _saveDouble('age_max', v.end);
                  },
                ),
                PrivacySection(
                  profileVisible: _profileVisible,
                  onVisibleChanged: (v) {
                    setState(() => _profileVisible = v);
                    _saveBool('profile_visible', v);
                  },
                ),
                AccountSection(
                  onChangePassword: _showChangePasswordDialog,
                  onLogout: _logout,
                  onDeleteAccount: _confirmDeleteAccount,
                ),
                const AboutSection(),
                const SizedBox(height: 32),
              ],
            ),
    );
  }
}

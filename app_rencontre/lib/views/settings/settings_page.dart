import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import 'sections/notifications_section.dart';
import 'sections/discovery_section.dart';
import 'sections/privacy_section.dart';
import 'sections/account_section.dart';
import 'sections/about_section.dart';
import 'dialogs/change_password_dialog.dart';
import 'dialogs/delete_account_dialog.dart';

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
  String _username = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final profile = await FirestoreService().getMyProfile();
      if (mounted) _username = profile?.username ?? '';
    } catch (_) {}
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
    showDialog(
      context: context,
      builder: (_) => const ChangePasswordDialog(),
    );
  }

  Future<void> _logout() async {
    await AuthService().logout();
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (_) => DeleteAccountDialog(username: _username),
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

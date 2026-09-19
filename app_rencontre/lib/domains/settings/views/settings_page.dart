import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/auth/services/auth_service.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/settings/sections/notifications_section.dart';
import 'package:nocturne/domains/settings/sections/privacy_section.dart';
import 'package:nocturne/domains/settings/sections/account_section.dart';
import 'package:nocturne/domains/settings/sections/about_section.dart';
import 'package:nocturne/domains/settings/sections/admin_section.dart';
import 'package:nocturne/domains/settings/dialogs/change_password_dialog.dart';
import 'package:nocturne/domains/settings/dialogs/delete_account_dialog.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';

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
  String _username = '';
  AlternativeProfile? _profile;
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
      if (mounted) {
      _username = profile?.username ?? '';
      _profile = profile;
      }
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _notifMatches    = prefs.getBool('notif_matches')    ?? true;
      _notifMessages   = prefs.getBool('notif_messages')   ?? true;
      _notifElegies    = prefs.getBool('notif_elegies')    ?? true;
      _profileVisible  = prefs.getBool('profile_visible')  ?? true;
      _loading = false;
    });
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _editProfile() {
    Navigator.pushNamed(
      context,'/edit-profile',
      arguments: _profile ?? AlternativeProfile(
        id: '', uid: '', username: '', avatarUrl: '', bio: ''
        ),
    );
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
        title: Text(
          AppLocalizations.of(context)!.settingsTitle,
          style: const TextStyle(
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
                PrivacySection(
                  profileVisible: _profileVisible,
                  onVisibleChanged: (v) {
                    setState(() => _profileVisible = v);
                    _saveBool('profile_visible', v);
                  },
                ),
                AccountSection(
                  onEditProfile: _editProfile,
                  onChangePassword: _showChangePasswordDialog,
                  onLogout: _logout,
                  onDeleteAccount: _confirmDeleteAccount,
                ),
                const AboutSection(),
                const AdminSection(),
                const SizedBox(height: 32),
              ],
            ),
    );
  }
}

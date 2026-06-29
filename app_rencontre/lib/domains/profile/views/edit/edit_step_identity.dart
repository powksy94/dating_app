import 'package:flutter/material.dart';
import 'package:nocturne/core/gender_options.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/profile/widgets/profile_bio_field.dart';
import 'package:nocturne/domains/profile/widgets/profile_locked_username.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/auth/widgets/chip_selector.dart';

class EditStepIdentity extends StatefulWidget {
  final AlternativeProfile profile;
  const EditStepIdentity({super.key, required this.profile});

  @override
  State<EditStepIdentity> createState() => _EditStepIdentityState();
}

class _EditStepIdentityState extends State<EditStepIdentity> {
  late final TextEditingController _bioCtrl;
  String? _gender;
  String? _pronouns;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _bioCtrl  = TextEditingController(text: widget.profile.bio);
    _gender   = widget.profile.gender;
    _pronouns = widget.profile.pronouns;
  }

  @override
  void dispose() {
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await FirestoreService().saveProfile({
        'bio':      _bioCtrl.text.trim(),
        'gender':   _gender,
        'pronouns': _pronouns,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.profileSnackIdentityUpdated),
            backgroundColor: const Color(0xFF7B00D4),
          ),
        );
      }
    } catch (_) {} finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(l.profileLabelUsername),
          const SizedBox(height: 6),
          ProfileLockedUsername(username: widget.profile.username),
          const SizedBox(height: 20),
          _label(l.profileLabelBio),
          const SizedBox(height: 6),
          ProfileBioField(controller: _bioCtrl),
          const SizedBox(height: 20),
          ChipSelector(
            title: l.profileLabelGender,
            options: genderOptions(l),
            selected: _gender,
            onSelected: (v) => setState(() => _gender = v),
            onCustomChanged: (_) {},
            fadeDelayMs: 0,
          ),
          const SizedBox(height: 20),
          ChipSelector(
            title: l.profileLabelPronouns,
            options: pronounOptions(l),
            selected: _pronouns,
            onSelected: (v) => setState(() => _pronouns = v),
            onCustomChanged: (_) {},
            fadeDelayMs: 0,
          ),
          const SizedBox(height: 32),
          _saveButton(),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          color: Color(0xFF7B00D4),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2));

  Widget _saveButton() => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: _saving ? null : _save,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7B00D4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)),
      ),
      child: _saving
          ? const CircularProgressIndicator(
              color: Colors.white, strokeWidth: 2)
          : Text(AppLocalizations.of(context)!.profileBtnSave,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
    ),
  );
}

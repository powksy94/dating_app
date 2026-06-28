import 'package:flutter/material.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
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

  static const _genders = [
    ChipOption('male', 'Homme'),
    ChipOption('female', 'Femme'),
    ChipOption('non_binary', 'Non-binaire'),
    ChipOption('genderfluid', 'Genderfluid'),
    ChipOption('agender', 'Agenre'),
    ChipOption('transmasculine', 'Transmasculin'),
    ChipOption('transfeminine', 'Transféminin'),
    ChipOption('other', 'Autre'),
  ];
  static const _pronounsList = [
    ChipOption('he_him', 'Il/lui'),
    ChipOption('she_her', 'Elle/elle'),
    ChipOption('they_them', 'Iel/iel'),
    ChipOption('plural_neutral', 'Eux/eux'),
    ChipOption('other', 'Autre'),
  ];

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
          const SnackBar(
            content: Text('Identité mise à jour !'),
            backgroundColor: Color(0xFF7B00D4),
          ),
        );
      }
    } catch (_) {} finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('PSEUDO'),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0A1F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2D0040)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_outline,
                    size: 14, color: Color(0xFF5A4A6A)),
                const SizedBox(width: 8),
                Text(widget.profile.username,
                    style: const TextStyle(
                        color: Color(0xFF5A4A6A), fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text('Le pseudo ne peut pas être modifié ici.',
              style: TextStyle(color: Color(0xFF3D2A4A), fontSize: 11)),
          const SizedBox(height: 20),
          _label('BIO'),
          const SizedBox(height: 6),
          ValueListenableBuilder(
            valueListenable: _bioCtrl,
            builder: (_, val, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _bioCtrl,
                  maxLines: 4,
                  maxLength: 700,
                  buildCounter: (_, {required currentLength,
                      required isFocused, maxLength}) => null,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Parle de toi, de ta musique...',
                    hintStyle:
                        const TextStyle(color: Color(0xFF5A4A6A)),
                    filled: true,
                    fillColor: const Color(0xFF1A0A1F),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF3D2A4A))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF3D2A4A))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF7B00D4))),
                  ),
                ),
                const SizedBox(height: 4),
                Text('${val.text.length}/700',
                    style: const TextStyle(
                        color: Color(0xFF5A4A6A), fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ChipSelector(
            title: 'Genre',
            options: _genders,
            selected: _gender,
            onSelected: (v) => setState(() => _gender = v),
            onCustomChanged: (_) {},
            fadeDelayMs: 0,
          ),
          const SizedBox(height: 20),
          ChipSelector(
            title: 'Pronoms',
            options: _pronounsList,
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
          : const Text('Sauvegarder',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
    ),
  );
}

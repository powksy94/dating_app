import 'package:flutter/material.dart';
import '../models/alternative_profile.dart';
import '../services/firestore_service.dart';
import '../core/music_tags.dart';
import '../widgets/tag_section.dart';

class ProfileEditPage extends StatefulWidget {
  final AlternativeProfile profile;
  const ProfileEditPage({super.key, required this.profile});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late final TextEditingController _bioCtrl;
  late final TextEditingController _bandsCtrl;
  late List<String> _genres;
  late List<String> _vibes;
  late List<String> _aesthetics;
  late List<String> _intensity;
  late List<String> _eras;
  late List<String> _discovery;

  @override
  void initState() {
    super.initState();
    _bioCtrl    = TextEditingController(text: widget.profile.bio);
    _bandsCtrl  = TextEditingController(
        text: widget.profile.favoriteBands.join(', '));
    _genres     = List.from(widget.profile.musicGenres);
    _vibes      = List.from(widget.profile.musicVibes);
    _aesthetics = List.from(widget.profile.aesthetics);
    _intensity  = List.from(widget.profile.soundIntensity);
    _eras       = List.from(widget.profile.musicEras);
    _discovery  = List.from(widget.profile.discoveryFormats);
  }

  @override
  void dispose() {
    _bioCtrl.dispose();
    _bandsCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    try {
      await FirestoreService().saveProfile({
        'bio':              _bioCtrl.text.trim(),
        'musicGenres':      _genres,
        'musicVibes':       _vibes,
        'aesthetics':       _aesthetics,
        'soundIntensity':   _intensity,
        'musicEras':        _eras,
        'discoveryFormats': _discovery,
        'favoriteBands': _bandsCtrl.text
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profil mis à jour !')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur : $e')));
    }
  }

  void _toggle(List<String> list, bool add, String tag) =>
      setState(() => add ? list.add(tag) : list.remove(tag));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ÉDITER MON PROFIL')),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(label: 'Bio', ctrl: _bioCtrl, maxLines: 4),
            const SizedBox(height: 24),
            TagSection(
              title: '1 · Genres musicaux',
              subtitle: 'Ton identité sonore principale',
              tags: kMusicGenres,
              selected: _genres,
              onToggle: (v, t) => _toggle(_genres, v, t),
            ),
            const SizedBox(height: 20),
            TagSection(
              title: '2 · Ambiance musicale',
              subtitle: 'Ce que tu ressens en écoutant',
              tags: kMusicVibes,
              selected: _vibes,
              onToggle: (v, t) => _toggle(_vibes, v, t),
            ),
            const SizedBox(height: 20),
            TagSection(
              title: '3 · Esthétique & culture',
              subtitle: 'Ta scène, ton style de vie',
              tags: kAesthetics,
              selected: _aesthetics,
              onToggle: (v, t) => _toggle(_aesthetics, v, t),
            ),
            const SizedBox(height: 20),
            TagSection(
              title: '4 · Intensité sonore',
              subtitle: 'L\'énergie de ta musique',
              tags: kSoundIntensity,
              selected: _intensity,
              onToggle: (v, t) => _toggle(_intensity, v, t),
            ),
            const SizedBox(height: 20),
            TagSection(
              title: '5 · Époque / scène',
              subtitle: 'Ta nostalgie générationnelle',
              tags: kMusicEras,
              selected: _eras,
              onToggle: (v, t) => _toggle(_eras, v, t),
            ),
            const SizedBox(height: 20),
            TagSection(
              title: '6 · Découverte musicale',
              subtitle: 'Tes habitudes d\'écoute',
              tags: kDiscoveryFormats,
              selected: _discovery,
              onToggle: (v, t) => _toggle(_discovery, v, t),
            ),
            const SizedBox(height: 20),
            _Field(
              label: 'Artistes favoris (séparés par des virgules)',
              ctrl: _bandsCtrl,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final int maxLines;
  const _Field({required this.label, required this.ctrl, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFF7B00D4),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          style: const TextStyle(color: Color(0xFFE8E0EE)),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1A0A1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF7B00D4)),
            ),
          ),
        ),
      ],
    );
  }
}

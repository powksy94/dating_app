import 'package:flutter/material.dart';
import 'package:nocturne/core/music_tags.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/shared/widgets/common/tag_section.dart';

class EditStepTags extends StatefulWidget {
  final AlternativeProfile profile;
  const EditStepTags({super.key, required this.profile});

  @override
  State<EditStepTags> createState() => _EditStepTagsState();
}

class _EditStepTagsState extends State<EditStepTags> {
  late List<String> _genres;
  late List<String> _vibes;
  late List<String> _aesthetics;
  late List<String> _intensity;
  late List<String> _eras;
  late List<String> _discovery;
  late final TextEditingController _bandsCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _genres     = List.from(widget.profile.musicGenres);
    _vibes      = List.from(widget.profile.musicVibes);
    _aesthetics = List.from(widget.profile.aesthetics);
    _intensity  = List.from(widget.profile.soundIntensity);
    _eras       = List.from(widget.profile.musicEras);
    _discovery  = List.from(widget.profile.discoveryFormats);
    _bandsCtrl  = TextEditingController(
        text: widget.profile.favoriteBands.join(', '));
  }

  @override
  void dispose() {
    _bandsCtrl.dispose();
    super.dispose();
  }

  void _toggle(List<String> list, bool add, String tag) =>
      setState(() => add ? list.add(tag) : list.remove(tag));

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await FirestoreService().saveProfile({
        'musicsGenres':     _genres,
        'musicsVibes':      _vibes,
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tags musicaux mis à jour !'),
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
          TagSection(
            title: 'Genres musicaux',
            subtitle: 'Ton identité sonore principale',
            tags: kMusicGenres,
            selected: _genres,
            onToggle: (v, t) => _toggle(_genres, v, t),
          ),
          const SizedBox(height: 20),
          TagSection(
            title: 'Ambiance musicale',
            subtitle: 'Ce que tu ressens en écoutant',
            tags: kMusicVibes,
            selected: _vibes,
            onToggle: (v, t) => _toggle(_vibes, v, t),
          ),
          const SizedBox(height: 20),
          TagSection(
            title: 'Esthétique & culture',
            subtitle: 'Ta scène, ton style de vie',
            tags: kAesthetics,
            selected: _aesthetics,
            onToggle: (v, t) => _toggle(_aesthetics, v, t),
          ),
          const SizedBox(height: 20),
          TagSection(
            title: 'Intensité sonore',
            subtitle: "L'énergie de ta musique",
            tags: kSoundIntensity,
            selected: _intensity,
            onToggle: (v, t) => _toggle(_intensity, v, t),
          ),
          const SizedBox(height: 20),
          TagSection(
            title: 'Époque / scène',
            subtitle: 'Ta nostalgie générationnelle',
            tags: kMusicEras,
            selected: _eras,
            onToggle: (v, t) => _toggle(_eras, v, t),
          ),
          const SizedBox(height: 20),
          TagSection(
            title: 'Découverte musicale',
            subtitle: "Tes habitudes d'écoute",
            tags: kDiscoveryFormats,
            selected: _discovery,
            onToggle: (v, t) => _toggle(_discovery, v, t),
          ),
          const SizedBox(height: 20),
          const Text('ARTISTES FAVORIS',
              style: TextStyle(
                  color: Color(0xFF7B00D4),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          const SizedBox(height: 6),
          TextField(
            controller: _bandsCtrl,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Bauhaus, The Cure, Depeche Mode...',
              hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
              filled: true,
              fillColor: const Color(0xFF1A0A1F),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF7B00D4))),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
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
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

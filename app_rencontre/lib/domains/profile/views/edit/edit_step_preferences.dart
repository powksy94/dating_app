import 'package:flutter/material.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';

class EditStepPreferences extends StatefulWidget {
  final AlternativeProfile profile;
  const EditStepPreferences({super.key, required this.profile});

  @override
  State<EditStepPreferences> createState() => _EditStepPreferencesState();
}

class _EditStepPreferencesState extends State<EditStepPreferences> {
  late RangeValues _ageRange;
  late double _maxDistance;
  late List<String> _genderPrefs;
  bool _saving = false;

  static const _genders = [
    'Homme', 'Femme', 'Non-binaire', 'Genderfluid',
    'Agenre', 'Transmasculin', 'Transféminin', 'Tous',
  ];

  @override
  void initState() {
    super.initState();
    _ageRange    = RangeValues(widget.profile.ageMin, widget.profile.ageMax);
    _maxDistance = widget.profile.maxDistance;
    _genderPrefs = List.from(widget.profile.genderPreferences);
  }

  void _toggleGender(String g) => setState(() =>
      _genderPrefs.contains(g)
          ? _genderPrefs.remove(g)
          : _genderPrefs.add(g));

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await FirestoreService().saveProfile({
        'ageMin':             _ageRange.start.round(),
        'ageMax':             _ageRange.end.round(),
        'maxDistance':        _maxDistance.round(),
        'genderPreferences':  _genderPrefs,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Préférences mises à jour !'),
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
          _label('TRANCHE D\'ÂGE'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_ageRange.start.round()} ans',
                  style: const TextStyle(
                      color: Color(0xFFAA9AB5), fontSize: 13)),
              Text('${_ageRange.end.round()} ans',
                  style: const TextStyle(
                      color: Color(0xFFAA9AB5), fontSize: 13)),
            ],
          ),
          RangeSlider(
            values: _ageRange,
            min: 18,
            max: 80,
            divisions: 62,
            activeColor: const Color(0xFF7B00D4),
            inactiveColor: const Color(0xFF3D2A4A),
            onChanged: (v) => setState(() => _ageRange = v),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _label('DISTANCE MAX'),
              Text('${_maxDistance.round()} km',
                  style: const TextStyle(
                      color: Color(0xFF7B00D4), fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          Slider(
            value: _maxDistance,
            min: 5,
            max: 300,
            divisions: 59,
            activeColor: const Color(0xFF7B00D4),
            inactiveColor: const Color(0xFF3D2A4A),
            onChanged: (v) => setState(() => _maxDistance = v),
          ),
          const SizedBox(height: 24),
          _label('GENRE RECHERCHÉ'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _genders.map((g) {
              final selected = _genderPrefs.contains(g);
              return GestureDetector(
                onTap: () => _toggleGender(g),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF7B00D4)
                        : const Color(0xFF1A0A1F),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF7B00D4)
                          : const Color(0xFF3D2A4A),
                    ),
                  ),
                  child: Text(g,
                      style: TextStyle(
                          color: selected
                              ? Colors.white
                              : const Color(0xFF5A4A6A),
                          fontSize: 13)),
                ),
              );
            }).toList(),
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

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          color: Color(0xFF7B00D4),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2));
}

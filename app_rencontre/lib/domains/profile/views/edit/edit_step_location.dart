import 'package:flutter/material.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/shared/services/nominatim_service.dart';
import 'package:nocturne/shared/widgets/location/address_search_field.dart';

class EditStepLocation extends StatefulWidget {
  final AlternativeProfile profile;
  const EditStepLocation({super.key, required this.profile});

  @override
  State<EditStepLocation> createState() => _EditStepLocationState();
}

class _EditStepLocationState extends State<EditStepLocation> {
  NominatimResult? _selected;
  bool _saving = false;

  Future<void> _save() async {
    if (_selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sélectionne une adresse')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await FirestoreService().saveProfile({
        'location': {
          'type': 'Point',
          'coordinates': [_selected!.lng, _selected!.lat],
        },
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Localisation mise à jour !'),
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
          const Text('LOCALISATION',
              style: TextStyle(
                  color: Color(0xFF7B00D4),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          const SizedBox(height: 4),
          const Text(
            'Utilisée pour trouver des profils et événements proches de toi.',
            style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
          ),
          const SizedBox(height: 20),
          AddressSearchField(
            onSelected: (result) => setState(() => _selected = result),
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
        ],
      ),
    );
  }
}

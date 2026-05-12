import 'package:flutter/material.dart';
import '../../../services/nominatim_service.dart';
import '../../../widgets/location/address_search_field.dart';

class StepLocation extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;
  const StepLocation({super.key, required this.onNext});

  @override
  State<StepLocation> createState() => _StepLocationState();
}

class _StepLocationState extends State<StepLocation> {
  NominatimResult? _selected;
  String?          _error;

  void _next() {
    if (_selected == null) {
      setState(() => _error = 'Sélectionne une adresse dans la liste');
      return;
    }
    widget.onNext({
      'address': _selected!.displayName,
      'city':    _selected!.city,
      'lat':     _selected!.lat,
      'lng':     _selected!.lng,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Où se déroule-t-il ?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Recherche l\'adresse du lieu',
              style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 24),
          AddressSearchField(
            onSelected: (result) => setState(() => _selected = result),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!,
                style: const TextStyle(
                    color: Color(0xFFD400FF), fontSize: 12)),
          ],
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Continuer',
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

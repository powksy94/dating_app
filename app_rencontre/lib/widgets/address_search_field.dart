import 'package:flutter/material.dart';
import '../services/nominatim_service.dart';

class AddressSearchField extends StatefulWidget {
  final void Function(NominatimResult) onSelected;

  const AddressSearchField({super.key, required this.onSelected});

  @override
  State<AddressSearchField> createState() => _AddressSearchFieldState();
}

class _AddressSearchFieldState extends State<AddressSearchField> {
  final _ctrl = TextEditingController();
  List<NominatimResult> _suggestions  = [];
  bool                  _searching    = false;
  NominatimResult?      _selected;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    setState(() => _searching = true);
    final results = await NominatimService.search(query);
    if (mounted) setState(() { _suggestions = results; _searching = false; });
  }

  void _select(NominatimResult result) {
    setState(() {
      _selected     = result;
      _ctrl.text    = result.displayName;
      _suggestions  = [];
    });
    widget.onSelected(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _ctrl,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            labelText: 'Adresse *',
            labelStyle:
                const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
            filled: true,
            fillColor: const Color(0xFF0D0010),
            prefixIcon: const Icon(Icons.location_on_outlined,
                size: 18, color: Color(0xFF5A4A6A)),
            suffixIcon: _searching
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Color(0xFF7B00D4))))
                : (_selected != null
                    ? const Icon(Icons.check_circle_outline,
                        color: Color(0xFF7B00D4), size: 18)
                    : null),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF7B00D4))),
          ),
          onChanged: (q) {
            setState(() => _selected = null);
            _search(q);
          },
        ),
        if (_suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1A0A1F),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF3D2A4A)),
            ),
            child: Column(
              children: _suggestions
                  .map((s) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.place_outlined,
                            size: 16, color: Color(0xFF5A4A6A)),
                        title: Text(s.displayName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        onTap: () => _select(s),
                      ))
                  .toList(),
            ),
          ),
        if (_selected != null) ...[
          const SizedBox(height: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0D0020),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF7B00D4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline,
                    size: 16, color: Color(0xFF7B00D4)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selected!.city.isNotEmpty
                        ? _selected!.city
                        : _selected!.displayName,
                    style: const TextStyle(
                        color: Color(0xFFAA9AB5), fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

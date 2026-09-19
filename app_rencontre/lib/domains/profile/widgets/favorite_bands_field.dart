import 'package:flutter/material.dart';
import 'package:nocturne/core/band_name.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/widgets/band_chip.dart';
import 'package:nocturne/domains/profile/widgets/bands_delete_toggle.dart';

/// Favorite bands entry: type a name, press add (or the keyboard action) and it
/// becomes a pastille. A name is free text, so it may contain a comma. A band
/// that is already in the list is refused whatever its case or spacing. The
/// trash button switches to delete mode, where each pastille can be removed.
class FavoriteBandsField extends StatefulWidget {
  final List<String> bands;
  final ValueChanged<List<String>> onChanged;
  final String hint;

  const FavoriteBandsField({
    super.key,
    required this.bands,
    required this.onChanged,
    required this.hint,
  });

  @override
  State<FavoriteBandsField> createState() => _FavoriteBandsFieldState();
}

class _FavoriteBandsFieldState extends State<FavoriteBandsField> {
  static const _maxLength = 60;
  final _controller = TextEditingController();
  bool _duplicate = false;
  bool _deleteMode = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final name = _controller.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (bandKey(name).isEmpty) return;
    if (containsBand(widget.bands, name)) {
      setState(() => _duplicate = true);
      return;
    }
    widget.onChanged([...widget.bands, name]);
    _controller.clear();
  }

  void _remove(String band) {
    final remaining = widget.bands.where((b) => b != band).toList();
    if (remaining.isEmpty) setState(() => _deleteMode = false);
    widget.onChanged(remaining);
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLength: _maxLength,
                textInputAction: TextInputAction.done,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                onChanged: (_) {
                  if (_duplicate) setState(() => _duplicate = false);
                },
                onSubmitted: (_) => _add(),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
                  errorText: _duplicate ? l.profileBandAlreadyAdded : null,
                  counterText: '',
                  filled: true,
                  fillColor: const Color(0xFF1A0A1F),
                  border: _border(const Color(0xFF3D2A4A)),
                  enabledBorder: _border(const Color(0xFF3D2A4A)),
                  focusedBorder: _border(const Color(0xFF7B00D4)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: _add,
              icon: const Icon(Icons.add_circle, color: Color(0xFF7B00D4), size: 32),
            ),
            if (widget.bands.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: BandsDeleteToggle(
                  active: _deleteMode,
                  onPressed: () => setState(() => _deleteMode = !_deleteMode),
                ),
              ),
          ],
        ),
        if (widget.bands.isNotEmpty) ...[
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: 0,
            children: [
              for (final (index, band) in widget.bands.indexed)
                BandChip(
                  label: band,
                  deleteMode: _deleteMode,
                  index: index,
                  onDelete: () => _remove(band),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

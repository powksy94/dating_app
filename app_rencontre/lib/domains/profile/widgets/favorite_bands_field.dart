import 'package:flutter/material.dart';
import 'package:nocturne/core/band_moderation.dart';
import 'package:nocturne/core/band_name.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/widgets/band_chip.dart';
import 'package:nocturne/domains/profile/widgets/band_text_field.dart';
import 'package:nocturne/domains/profile/widgets/bands_delete_toggle.dart';

/// Favorite bands entry: type a name, press add (or the keyboard action) and it
/// becomes a pastille. A name is free text, so it may contain a comma. A band
/// that is already in the list is refused whatever its case or spacing, and so
/// is a name with an insult or a link. The trash button switches to delete
/// mode, where each pastille can be removed.
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
  String? _error;
  bool _deleteMode = false;

  @override
  void initState() {
    super.initState();
    // Building the word lists takes a moment: do it once the screen is shown,
    // not before, so opening the screen does not stall.
    WidgetsBinding.instance.addPostFrameCallback((_) => prepareBandModeration());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final name = _controller.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (bandKey(name).isEmpty) return;
    final l = AppLocalizations.of(context)!;
    if (containsBand(widget.bands, name)) {
      setState(() => _error = l.profileBandAlreadyAdded);
      return;
    }
    if (isBandNameRefused(name)) {
      setState(() => _error = l.profileBandNotAllowed);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BandTextField(
                controller: _controller,
                hint: widget.hint,
                errorText: _error,
                maxLength: _maxLength,
                onChanged: (_) {
                  if (_error != null) setState(() => _error = null);
                },
                onSubmitted: _add,
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nocturne/core/band_moderation.dart';
import 'package:nocturne/core/band_name.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/favorite_band.dart';
import 'package:nocturne/domains/profile/services/band_search_service.dart';
import 'package:nocturne/domains/profile/widgets/band_chip.dart';
import 'package:nocturne/domains/profile/widgets/band_text_field.dart';
import 'package:nocturne/domains/profile/widgets/bands_delete_toggle.dart';

/// Favorite bands entry: type a name and either pick a live Spotify search
/// result (with its photo) or press add/the keyboard action to keep the
/// typed text as a plain pastille. A name is free text, so it may contain a
/// comma. A band already in the list is refused whatever its case or
/// spacing, and so is a name with an insult or a link. The trash button
/// switches to delete mode, where each pastille can be removed.
///
/// Search is best-effort: when it returns nothing (no Spotify credentials
/// configured on the backend, or the request failed), typing and pressing
/// add still works exactly as before, with no error shown for it.
class FavoriteBandsField extends StatefulWidget {
  final List<FavoriteBand> bands;
  final ValueChanged<List<FavoriteBand>> onChanged;
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
  static const _minQueryLength = 2;
  final _controller = TextEditingController();
  String? _error;
  bool _deleteMode = false;
  Timer? _debounce;
  List<BandSearchResult> _results = [];

  @override
  void initState() {
    super.initState();
    // Building the word lists takes a moment: do it once the screen is shown,
    // not before, so opening the screen does not stall.
    WidgetsBinding.instance.addPostFrameCallback((_) => prepareBandModeration());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String text) {
    if (_error != null) setState(() => _error = null);
    _debounce?.cancel();
    final query = text.trim();
    if (query.length < _minQueryLength) {
      if (_results.isNotEmpty) setState(() => _results = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      final results = await BandSearchService.search(query);
      if (mounted) setState(() => _results = results);
    });
  }

  void _addBand(FavoriteBand band) {
    final l = AppLocalizations.of(context)!;
    if (containsBand(widget.bands.map((b) => b.name), band.name)) {
      setState(() => _error = l.profileBandAlreadyAdded);
      return;
    }
    // Same check for a typed name and a Spotify pick: the name ends up in a
    // message sent under this user's name either way (see build-suggestions.ts).
    if (isBandNameRefused(band.name)) {
      setState(() => _error = l.profileBandNotAllowed);
      return;
    }
    widget.onChanged([...widget.bands, band]);
    _controller.clear();
    setState(() => _results = []);
  }

  void _addFreeText() {
    final name = _controller.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (bandKey(name).isEmpty) return;
    _addBand(FavoriteBand(name: name));
  }

  void _remove(FavoriteBand band) {
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
                onChanged: _onTextChanged,
                onSubmitted: _addFreeText,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: _addFreeText,
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
        if (_results.isNotEmpty) ...[
          const SizedBox(height: 6),
          _SearchResultsList(
            results: _results,
            onPick: (result) => _addBand(FavoriteBand(
              name: result.name,
              imageUrl: result.imageUrl,
              spotifyId: result.id,
            )),
          ),
        ],
        if (widget.bands.isNotEmpty) ...[
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: 0,
            children: [
              for (final (index, band) in widget.bands.indexed)
                BandChip(
                  label: band.name,
                  imageUrl: band.imageUrl,
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

class _SearchResultsList extends StatelessWidget {
  final List<BandSearchResult> results;
  final ValueChanged<BandSearchResult> onPick;

  const _SearchResultsList({required this.results, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3D2A4A)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final result in results)
            ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFF2A1A35),
                backgroundImage:
                    result.imageUrl != null ? NetworkImage(result.imageUrl!) : null,
                child: result.imageUrl == null
                    ? const Icon(Icons.music_note, size: 16, color: Color(0xFF7B00D4))
                    : null,
              ),
              title: Text(result.name, style: const TextStyle(color: Colors.white, fontSize: 14)),
              onTap: () => onPick(result),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              AppLocalizations.of(context)!.bandSearchAttribution,
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

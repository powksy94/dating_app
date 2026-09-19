import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/models/search_filters.dart';
import 'package:nocturne/domains/discovery/services/search_filters_service.dart';
import 'package:nocturne/domains/discovery/widgets/filters_apply_button.dart';
import 'package:nocturne/domains/discovery/widgets/filters_panel_header.dart';
import 'package:nocturne/domains/settings/widgets/range_tile.dart';
import 'package:nocturne/domains/settings/widgets/slider_tile.dart';

/// Age range and max distance filters, shown above the discovery content.
class SearchFiltersPanel extends StatefulWidget {
  /// Called once the filters are saved, so the feed can be reloaded.
  final VoidCallback onApplied;
  final VoidCallback onClose;

  const SearchFiltersPanel({
    super.key,
    required this.onApplied,
    required this.onClose,
  });

  @override
  State<SearchFiltersPanel> createState() => _SearchFiltersPanelState();
}

class _SearchFiltersPanelState extends State<SearchFiltersPanel> {
  SearchFilters? _filters;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final filters = await SearchFiltersService.load();
      if (filters == null) return _fail();
      if (mounted) setState(() => _filters = filters);
    } catch (_) {
      _fail();
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context)!.commonGenericError),
      backgroundColor: const Color(0xFF7F1D1D),
    ));
  }

  void _fail() {
    if (!mounted) return;
    _showError();
    widget.onClose();
  }

  Future<void> _apply() async {
    setState(() => _saving = true);
    try {
      await SearchFiltersService.save(_filters!);
      widget.onApplied();
    } catch (_) {
      if (mounted) _showError();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = _filters;
    return Container(
      width: double.infinity,
      color: const Color(0xFF120018),
      padding: const EdgeInsets.only(bottom: 12),
      child: filters == null
          ? const SizedBox(height: 120, child: Center(child: CircularProgressIndicator()))
          : _content(context, filters),
    );
  }

  Widget _content(BuildContext context, SearchFilters filters) {
    final l = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FiltersPanelHeader(onClose: widget.onClose),
        SliderTile(
          icon: Icons.location_on_outlined,
          label: l.settingsLabelMaxDistance,
          valueLabel: l.settingsValueKm(filters.maxDistance.round()),
          value: filters.maxDistance,
          min: SearchFilters.distanceLimitMin,
          max: SearchFilters.distanceLimitMax,
          onChanged: (v) => setState(() => _filters = filters.copyWith(maxDistance: v)),
        ),
        RangeTile(
          icon: Icons.people_outline,
          label: l.settingsLabelAgeRange,
          valueLabel: l.settingsValueAgeRange(
              filters.ageRange.start.round(), filters.ageRange.end.round()),
          values: filters.ageRange,
          min: SearchFilters.ageLimitMin,
          max: SearchFilters.ageLimitMax,
          onChanged: (v) => setState(() => _filters = filters.copyWith(ageRange: v)),
        ),
        FiltersApplyButton(saving: _saving, onPressed: _apply),
      ],
    );
  }
}

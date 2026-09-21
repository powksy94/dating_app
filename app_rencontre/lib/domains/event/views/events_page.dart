import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/domains/event/services/event_service.dart';
import 'package:nocturne/domains/profile/services/favorites_service.dart';
import 'package:nocturne/domains/event/widgets/event_card.dart';
import 'package:nocturne/domains/event/widgets/event_filter_chips.dart';
import 'package:nocturne/domains/event/widgets/event_filter_panel.dart';
import 'package:nocturne/domains/event/widgets/events_empty_state.dart';
import 'package:nocturne/domains/event/views/create_event_page.dart';
import 'package:nocturne/domains/event/views/event_detail_page.dart';
import 'package:nocturne/shared/mixins/reload_on_reconnect.dart';
import 'package:nocturne/shared/widgets/common/load_error_view.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with ReloadOnReconnect<EventsPage> {
  List<EventModel> _events    = [];
  Set<String>      _favorites = {};
  bool        _loading     = true;
  bool        _loadFailed  = false;
  double      _maxDistance = 50;
  Position?   _position;
  bool        _showFilter  = false;
  bool        _filterGenres = false;
  EventFilter _filter      = EventFilter.all;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  bool get needsReload => _loadFailed;

  @override
  void reloadAfterReconnect() => _loadEvents();

  Future<void> _init() async {
    await _getLocation();
    await Future.wait([_loadEvents(), _loadFavorites()]);
  }

  Future<void> _getLocation() async {
    try {
      // Without a time limit, a stuck permission dialog or a missing GPS fix
      // would keep the page loading forever (seen on a real device where the
      // system permission prompt behaves differently than on an emulator).
      final permission = await Geolocator.checkPermission()
          .timeout(const Duration(seconds: 8));
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission().timeout(const Duration(seconds: 30));
      }
      _position = await Geolocator.getCurrentPosition()
          .timeout(const Duration(seconds: 8));
    } catch (_) {
      try {
        _position = await Geolocator.getLastKnownPosition();
      } catch (_) {}
    }
  }

  Future<void> _loadFavorites() async {
    final favs = await FavoritesService.getAll();
    if (mounted) setState(() => _favorites = favs);
  }

  Future<void> _loadEvents() async {
    if (!mounted) return;
    setState(() { _loading = true; _loadFailed = false; });
    try {
      final events = await EventService.getEvents(
        lat:          _position?.latitude,
        lng:          _position?.longitude,
        maxDistance:  _maxDistance,
        filterGenres: _filterGenres,
      );
      if (mounted) setState(() { _events = events; _loading = false; });
    } catch (_) {
      if (mounted) setState(() { _loadFailed = true; _loading = false; });
    }
  }

  List<EventModel> get _filteredEvents {
    switch (_filter) {
      case EventFilter.attending:
        return _events.where((e) => e.isAttending).toList();
      case EventFilter.matches:
        return _events.where((e) => e.mutualAttendeesCount > 0).toList();
      case EventFilter.favorites:
        return _events.where((e) => _favorites.contains(e.id)).toList();
      case EventFilter.all:
        return _events;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.eventPageTitle,
          style: const TextStyle(
              fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.tune,
              color: _showFilter ? const Color(0xFF7B00D4) : Colors.white,
            ),
            onPressed: () => setState(() => _showFilter = !_showFilter),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7B00D4),
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CreateEventPage()));
          _loadEvents();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          EventFilterChips(
            current:   _filter,
            onChanged: (f) => setState(() => _filter = f),
          ),
          if (_showFilter)
            EventFilterPanel(
              maxDistance:          _maxDistance,
              filterGenres:         _filterGenres,
              onDistanceChanged:    (v) => setState(() => _maxDistance = v),
              onDistanceChangeEnd:  _loadEvents,
              onGenresChanged:      (v) {
                setState(() => _filterGenres = v);
                _loadEvents();
              },
            ),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_loadFailed) {
      final l = AppLocalizations.of(context)!;
      return LoadErrorView(
        title:      l.eventLoadErrorTitle,
        subtitle:   l.commonLoadErrorSubtitle,
        retryLabel: l.commonBtnRetry,
        onRetry:    _loadEvents,
      );
    }

    final filtered = _filteredEvents;

    if (filtered.isEmpty) {
      return EventsEmptyState(isAllFilter: _filter == EventFilter.all);
    }

    return RefreshIndicator(
      color: const Color(0xFF7B00D4),
      onRefresh: () async {
        await Future.wait([_loadEvents(), _loadFavorites()]);
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: filtered.length,
        itemBuilder: (_, i) => EventCard(
          event: filtered[i],
          onFavoriteToggled: _loadFavorites,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EventDetailPage(event: filtered[i]),
            ),
          ),
        ),
      ),
    );
  }
}

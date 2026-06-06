import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/domains/event/services/event_service.dart';
import 'package:nocturne/domains/profile/services/favorites_service.dart';
import 'package:nocturne/domains/event/widgets/event_card.dart';
import 'package:nocturne/domains/event/widgets/event_filter_chips.dart';
import 'package:nocturne/domains/event/views/create_event_page.dart';
import 'package:nocturne/domains/event/views/event_detail_page.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<EventModel> _events    = [];
  Set<String>      _favorites = {};
  bool        _loading     = true;
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

  Future<void> _init() async {
    await _getLocation();
    await Future.wait([_loadEvents(), _loadFavorites()]);
  }

  Future<void> _getLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      _position = await Geolocator.getCurrentPosition();
    } catch (_) {}
  }

  Future<void> _loadFavorites() async {
    final favs = await FavoritesService.getAll();
    if (mounted) setState(() => _favorites = favs);
  }

  Future<void> _loadEvents() async {
    if (!mounted) return;
    setState(() => _loading = true);
    final events = await EventService.getEvents(
      lat:          _position?.latitude,
      lng:          _position?.longitude,
      maxDistance:  _maxDistance,
      filterGenres: _filterGenres,
    );
    if (mounted) setState(() { _events = events; _loading = false; });
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
        title: const Text(
          'ÉVÉNEMENTS',
          style: TextStyle(
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
          if (_showFilter) _filterPanel(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _filterPanel() {
    return Container(
      color: const Color(0xFF1A0A1F),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Distance max',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              Text('${_maxDistance.round()} km',
                  style: const TextStyle(
                      color: Color(0xFF7B00D4), fontSize: 13)),
            ],
          ),
          Slider(
            value: _maxDistance,
            min: 5,
            max: 300,
            divisions: 59,
            activeColor: const Color(0xFF7B00D4),
            inactiveColor: const Color(0xFF3D2A4A),
            onChanged: (v) => setState(() => _maxDistance = v),
            onChangeEnd: (_) => _loadEvents(),
          ),
          const SizedBox(height: 4),
          const Text('Genres',
              style: TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            children: [
              _genreToggle('Tous les genres', !_filterGenres,
                  () { setState(() => _filterGenres = false); _loadEvents(); }),
              const SizedBox(width: 10),
              _genreToggle('Mes genres', _filterGenres,
                  () { setState(() => _filterGenres = true); _loadEvents(); }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genreToggle(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF7B00D4) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? const Color(0xFF7B00D4) : const Color(0xFF3D2A4A),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? Colors.white : const Color(0xFF5A4A6A),
                fontSize: 12)),
      ),
    );
  }

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());

    final filtered = _filteredEvents;

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.event_busy, size: 48, color: Color(0xFF3D2A4A)),
            const SizedBox(height: 12),
            Text(
              _filter == EventFilter.all
                  ? 'Aucun événement dans ta zone'
                  : 'Aucun événement dans cette catégorie',
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 14),
            ),
          ],
        ),
      );
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

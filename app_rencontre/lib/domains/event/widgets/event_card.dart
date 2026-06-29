import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/domains/event/services/event_service.dart';
import 'package:nocturne/domains/profile/services/favorites_service.dart';
import 'package:nocturne/domains/event/widgets/event_attendees_widget.dart';

class EventCard extends StatefulWidget {
  final EventModel event;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggled;

  const EventCard({super.key, required this.event, this.onTap, this.onFavoriteToggled});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late EventModel _event;
  bool _loadingAttend = false;
  bool _isFavorite    = false;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final fav = await FavoritesService.isFavorite(_event.id);
    if (mounted) setState(() => _isFavorite = fav);
  }

  Future<void> _toggleFavorite() async {
    await FavoritesService.toggle(_event.id);
    if (mounted) setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteToggled?.call();
  }

  Future<void> _toggleAttend() async {
    setState(() => _loadingAttend = true);
    final success = _event.isAttending
        ? await EventService.unattendEvent(_event.id)
        : await EventService.attendEvent(_event.id);

    if (mounted && success) {
      setState(() {
        _event = _event.copyWith(
          isAttending: !_event.isAttending,
          attendeeCount: _event.isAttending
              ? _event.attendeeCount - 1
              : _event.attendeeCount + 1,
        );
      });
    }
    if (mounted) setState(() => _loadingAttend = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3D2A4A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cover(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _genresChips(),
                  const SizedBox(height: 8),
                  Text(
                    _event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _dateLocationRow(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: EventAttendeesWidget(
                          mutualAttendees:      _event.mutualAttendees,
                          mutualAttendeesCount: _event.mutualAttendeesCount,
                          attendeeCount:        _event.attendeeCount,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _attendButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cover() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          _event.coverImageUrl.isNotEmpty
              ? Image.network(
                  _event.coverImageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 160,
                  color: const Color(0xFF2D0040),
                  child: const Center(
                    child: Icon(Icons.music_note,
                        size: 48, color: Color(0xFF7B00D4)),
                  ),
                ),
          Positioned(
            top: 10,
            right: 10,
            child: _priceBadge(),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                  color: _isFavorite
                      ? const Color(0xFFD400FF)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _event.isFree
            ? const Color(0xFF1A5C1A)
            : const Color(0xFF1A0A1F).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _event.isFree
              ? const Color(0xFF2ECC71)
              : const Color(0xFF7B00D4),
        ),
      ),
      child: Text(
        _event.isFree
            ? AppLocalizations.of(context)!.eventPriceFree
            : '${_event.price?.toStringAsFixed(0)} €',
        style: TextStyle(
          color: _event.isFree
              ? const Color(0xFF2ECC71)
              : const Color(0xFFD400FF),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _genresChips() {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: _event.genres.take(3).map((g) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF2D0040),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(g,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 11)),
      )).toList(),
    );
  }

  Widget _dateLocationRow() {
    final dateStr = formatEventDateCompact(context, _event.date);

    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined,
            size: 13, color: Color(0xFF5A4A6A)),
        const SizedBox(width: 4),
        Text(dateStr,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
        const SizedBox(width: 12),
        const Icon(Icons.location_on_outlined,
            size: 13, color: Color(0xFF5A4A6A)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            _event.distance != null
                ? '${_event.city} · ${_event.distance} km'
                : _event.city,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _attendButton() {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        onPressed: _loadingAttend ? null : _toggleAttend,
        style: ElevatedButton.styleFrom(
          backgroundColor: _event.isAttending
              ? const Color(0xFF2D0040)
              : const Color(0xFF7B00D4),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: _event.isAttending
                  ? const Color(0xFF7B00D4)
                  : Colors.transparent,
            ),
          ),
        ),
        child: _loadingAttend
            ? const SizedBox(
                width: 14, height: 14,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : Text(
                _event.isAttending
                    ? AppLocalizations.of(context)!.eventBadgeRegistered
                    : AppLocalizations.of(context)!.eventBtnRegister,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
      ),
    );
  }
}
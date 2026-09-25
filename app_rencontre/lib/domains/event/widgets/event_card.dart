import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/event/event_feature_flags.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/shared/widgets/common/coming_soon_dialog.dart';
import 'package:nocturne/domains/event/services/event_service.dart';
import 'package:nocturne/domains/profile/services/favorites_service.dart';
import 'package:nocturne/domains/event/widgets/event_attendees_widget.dart';
import 'package:nocturne/domains/event/widgets/event_card_cover.dart';
import 'package:nocturne/domains/event/widgets/event_card_genre_chips.dart';
import 'package:nocturne/domains/event/widgets/event_card_date_location_row.dart';
import 'package:nocturne/domains/event/widgets/event_attend_button.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

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
    if (!kPaidEventsEnabled && !_event.isFree && !_event.isAttending) {
      showComingSoonDialog(context,
          message: AppLocalizations.of(context)!.eventPaidComingSoonBody);
      return;
    }
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
    } else if (mounted) {
      showAppSnackBar(context, AppLocalizations.of(context)!.commonGenericError, backgroundColor: const Color(0xFF7F1D1D));
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
            EventCardCover(
              coverImageUrl:   _event.coverImageUrl,
              isFree:          _event.isFree,
              price:           _event.price,
              isFavorite:      _isFavorite,
              onToggleFavorite: _toggleFavorite,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventCardGenreChips(genres: _event.genres),
                  const SizedBox(height: 8),
                  Text(
                    _event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  EventCardDateLocationRow(
                    date:     _event.date,
                    city:     _event.city,
                    distance: _event.distance,
                  ),
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
                      EventAttendButton(
                        isAttending: _event.isAttending,
                        loading:     _loadingAttend,
                        onPressed:   _toggleAttend,
                      ),
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
}

import 'package:flutter/material.dart';
import '../../models/event_model.dart';
import '../../services/event_service.dart';
import 'event_attendees_widget.dart';

class EventCard extends StatefulWidget {
  final EventModel event;
  final VoidCallback? onTap;

  const EventCard({super.key, required this.event, this.onTap});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late EventModel _event;
  bool _loadingAttend = false;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  Future<void> _toggleAttend() async {
    setState(() => _loadingAttend = true);
    final success = _event.isAttending
        ? await EventService.unattendEvent(_event.id)
        : await EventService.unattendEvent(_event.id);

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

  // {soon}
}
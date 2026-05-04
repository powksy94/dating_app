import 'package:flutter/material.dart';
import '../../models/event_model.dart';
import '../../services/event_service.dart';
import '../../widgets/event/event_attendees_widget.dart';
import '../../widgets/section_block.dart';
import '../../widgets/event/event_cover_header.dart';
import '../../widgets/event/event_info_section.dart';
import '../../widgets/event/register_sheet.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;
  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late EventModel _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  void _showRegisterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0A1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => RegisterSheet(
        event: _event,
        onConfirm: _handleRegister,
      ),
    );
  }

  Future<void> _handleRegister() async {
    final success = _event.isAttending
        ? await EventService.unattendEvent(_event.id)
        : await EventService.attendEvent(_event.id);

    if (!mounted) return;
    if (success) {
      final wasAttending = _event.isAttending;
      setState(() {
        _event = _event.copyWith(
          isAttending:   !wasAttending,
          attendeeCount: wasAttending
              ? _event.attendeeCount - 1
              : _event.attendeeCount + 1,
        );
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(wasAttending
              ? 'Désinscription confirmée'
              : 'Inscription confirmée !'),
          backgroundColor: const Color(0xFF7B00D4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      body: CustomScrollView(
        slivers: [
          EventCoverHeader(coverImageUrl: _event.coverImageUrl),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _genreChips(),
                  const SizedBox(height: 12),
                  Text(
                    _event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  EventInfoSection(event: _event),
                  const SizedBox(height: 16),
                  SectionBlock(
                    title: 'DESCRIPTION',
                    child: Text(
                      _event.description,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SectionBlock(
                    title: 'PARTICIPANTS',
                    child: EventAttendeesWidget(
                      mutualAttendees:      _event.mutualAttendees,
                      mutualAttendeesCount: _event.mutualAttendeesCount,
                      attendeeCount:        _event.attendeeCount,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _genreChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: _event.genres.map((g) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF2D0040),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(g,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 12)),
      )).toList(),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Color(0xFF120018),
        border: Border(top: BorderSide(color: Color(0xFF2D0040))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _showRegisterSheet,
          style: ElevatedButton.styleFrom(
            backgroundColor: _event.isAttending
                ? const Color(0xFF2D0040)
                : const Color(0xFF7B00D4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: _event.isAttending
                    ? const Color(0xFF7B00D4)
                    : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            _event.isAttending ? 'Inscrit ✓ — Se désinscrire' : "S'inscrire",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

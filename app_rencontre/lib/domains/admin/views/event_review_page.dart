import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_event_review_service.dart';
import 'package:nocturne/domains/admin/services/event_review_actions.dart';
import 'package:nocturne/domains/admin/widgets/event_review_card.dart';

class EventReviewPage extends StatefulWidget {
  const EventReviewPage({super.key});

  @override
  State<EventReviewPage> createState() => _EventReviewPageState();
}

class _EventReviewPageState extends State<EventReviewPage> {
  List<Map<String, dynamic>> _events = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final events = await AdminEventReviewService.getPending();
    if (mounted) setState(() { _events = events; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final actions = EventReviewActions(
      context: context,
      onDecided: (eventId) => setState(() => _events.removeWhere((e) => e['_id'] == eventId)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0010),
        elevation: 0,
        title: Text(l.eventReviewTitle,
            style: const TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7B00D4)))
          : _events.isEmpty
              ? Center(
                  child: Text(l.eventReviewEmpty,
                      style: const TextStyle(color: Color(0xFFAA9AB5))))
              : RefreshIndicator(
                  onRefresh: _load,
                  color: const Color(0xFF7B00D4),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _events.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => EventReviewCard(
                      event: _events[i],
                      onApprove: () => actions.approve(_events[i]['_id'] as String),
                      onReject: () => actions.reject(_events[i]['_id'] as String),
                    ),
                  ),
                ),
    );
  }
}

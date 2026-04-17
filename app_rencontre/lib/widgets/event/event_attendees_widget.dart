import 'package:flutter/material.dart';
import '../../models/event_model.dart';

class EventAttendeesWidget extends StatelessWidget {
  final List<AttendeePreview> mutualAttendees;
  final int mutualAttendeesCount;
  final int attendeeCount;

  const EventAttendeesWidget({
    super.key,
    required this.mutualAttendees,
    required this.mutualAttendeesCount,
    required this.attendeeCount,
  });

  @override
  Widget build(BuildContext context) {
    if (mutualAttendeesCount > 0) {
      return Row(
        children: [
          _avatarStack(),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _mutualText(),
              style: const TextStyle(
                color: Color(0xFFAA9AB5),
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        const Icon(Icons.people_outline,
            size: 16, color: Color(0xFF5A4A6A)),
        const SizedBox(width: 6),
        Text(
          '$attendeeCount participant${attendeeCount > 1 ? 's' : ''}',
          style: const TextStyle(
              color: Color(0xFF5A4A6A), fontSize: 12),
        ),
      ],
    );
  }

  Widget _avatarStack() {
    final avatars = mutualAttendees.take(2).toList();
    return SizedBox(
      width: avatars.length == 1 ? 24 : 40,
      height: 24,
      child: Stack(
        children: [
          for (int i = 0; i < avatars.length; i++)
            Positioned(
              left: i * 16.0,
              child: _avatar(avatars[i].avatarUrl),
            ),
        ],
      ),
    );
  }

  Widget _avatar(String url) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: const Color(0xFF2D0040),
      backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
      child: url.isEmpty
          ? const Icon(Icons.person, size: 12, color: Color(0xFF7B00D4))
          : null,
    );
  }

  String _mutualText() {
    final names = mutualAttendees.take(2).map((a) => a.username).toList();
    final extra = mutualAttendeesCount - names.length;

    if (extra <= 0) return '${names.join(' et ')} participe${names.length > 1 ? 'nt' : ''}';
    return '${names.join(', ')} et $extra autre${extra > 1 ? 's' : ''} participent';
  }
}

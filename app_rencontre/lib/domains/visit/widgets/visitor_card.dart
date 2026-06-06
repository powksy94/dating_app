import 'package:flutter/material.dart';
import 'package:nocturne/domains/visit/models/visitor.dart';

class VisitorCard extends StatelessWidget {
  final Visitor visitor;
  const VisitorCard({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    final photo = visitor.photos.isNotEmpty ? visitor.photos.first : visitor.avatarUrl;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1A0A1F),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            photo.isNotEmpty
                ? Image.network(photo, fit: BoxFit.cover)
                : Container(
                    color: const Color(0xFF2D1A3A),
                    child: const Icon(Icons.person, color: Color(0xFF7B00D4), size: 48),
                  ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xDD0D0010)],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),
            ),
            if (visitor.visitedAt != null)
              Positioned(
                top: 8, right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A0A1F).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF7B00D4), width: 0.5),
                  ),
                  child: Text(
                    _timeAgo(visitor.visitedAt!),
                    style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 9),
                  ),
                ),
              ),
            Positioned(
              left: 10, right: 10, bottom: 10,
              child: Text(
                visitor.age != null ? '${visitor.username}, ${visitor.age}' : visitor.username,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes}min';
    if (diff.inHours < 24)   return 'il y a ${diff.inHours}h';
    return 'il y a ${diff.inDays}j';
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';

class MatchTile extends StatelessWidget {
  final ChatMatch match;
  final VoidCallback onTap;
  const MatchTile({super.key, required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xFF0D0010),
      onTap: onTap,
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: const Color(0xFF2D0040),
        backgroundImage: match.avatarUrl.isNotEmpty
            ? NetworkImage(match.avatarUrl)
            : null,
        child: match.avatarUrl.isEmpty
            ? const Icon(Icons.person, color: Color(0xFF7B00D4))
            : null,
      ),
      title: Text(
        match.username,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        match.lastMessageText ?? AppLocalizations.of(context)!.chatNewMatch,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: match.lastMessageText != null
              ? const Color(0xFFAA9AB5)
              : const Color(0xFF7B00D4),
          fontSize: 13,
          fontStyle: match.lastMessageText == null
              ? FontStyle.italic
              : FontStyle.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (match.lastMessageAt != null)
            Text(
              _formatTime(context, match.lastMessageAt!),
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11),
            ),
          if (match.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF7B00D4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                match.unreadCount > 99 ? '99+' : '${match.unreadCount}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(BuildContext context, DateTime dt) {
    final l = AppLocalizations.of(context)!;
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return l.chatTimeMinutesShort(diff.inMinutes);
    if (diff.inHours < 24) return l.chatTimeHoursShort(diff.inHours);
    return l.chatTimeDaysShort(diff.inDays);
  }
}

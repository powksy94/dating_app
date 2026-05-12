import 'package:flutter/material.dart';
import '../../models/chat_match.dart';
import '../report/report_block_sheet.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatMatch match;
  final bool      otherOnline;
  final bool      otherTyping;
  final String?   lastSeenText;

  const ChatAppBar({
    super.key,
    required this.match,
    required this.otherOnline,
    required this.otherTyping,
    this.lastSeenText,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF120018),
      toolbarHeight: 72,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF2D0040),
            backgroundImage: match.avatarUrl.isNotEmpty
                ? NetworkImage(match.avatarUrl)
                : null,
            child: match.avatarUrl.isEmpty
                ? const Icon(Icons.person,
                    color: Color(0xFF7B00D4), size: 18)
                : null,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(match.username,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 16)),
                  if (otherOnline) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2ECC71),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
              if (otherTyping)
                const Text('en train d\'écrire...',
                    style: TextStyle(
                        color: Color(0xFF7B00D4),
                        fontSize: 12,
                        fontStyle: FontStyle.italic))
              else if (!otherOnline && lastSeenText != null)
                Text(lastSeenText!,
                    style: const TextStyle(
                        color: Color(0xFF5A4A6A), fontSize: 11)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () => showReportBlockSheet(
            context,
            userId:   match.userId,
            username: match.username,
          ),
        ),
      ],
    );
  }
}

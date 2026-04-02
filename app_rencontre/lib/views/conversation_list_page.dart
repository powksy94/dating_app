import 'package:flutter/material.dart';
import '../models/chat_match.dart';
import '../services/chat_service.dart';
import 'conversation_page.dart';

class ConversationListPage extends StatefulWidget {
  const ConversationListPage({super.key});

  @override
  State<ConversationListPage> createState() => _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage> {
  List<ChatMatch> _matches = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final matches = await ChatService.getMatches();
      if (mounted) setState(() { _matches = matches; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF120018),
        title: const Text(
          'MESSAGES',
          style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 16),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _matches.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  itemCount: _matches.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Color(0xFF1A0A1F), height: 1),
                  itemBuilder: (context, i) => _MatchTile(
                    match: _matches[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConversationPage(match: _matches[i]),
                      ),
                    ).then((_) => _load()),
                  ),
                ),
    );
  }
}

class _MatchTile extends StatelessWidget {
  final ChatMatch match;
  final VoidCallback onTap;
  const _MatchTile({required this.match, required this.onTap});

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
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        match.lastMessageText ?? 'Nouveau match',
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
      trailing: match.lastMessageAt != null
          ? Text(
              _formatTime(match.lastMessageAt!),
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11),
            )
          : null,
    );
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24)   return '${diff.inHours}h';
    return '${diff.inDays}j';
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.nightlight, size: 64, color: Color(0xFF7B00D4)),
          SizedBox(height: 16),
          Text(
            'Aucun match pour l\'instant...',
            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Continue d\'explorer les ténèbres',
            style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

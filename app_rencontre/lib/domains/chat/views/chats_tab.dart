import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/chat/services/chat_service.dart';
import 'package:nocturne/shared/services/unread_service.dart';
import 'package:nocturne/domains/chat/views/conversation_page.dart';
import 'package:nocturne/domains/chat/widgets/chat_empty_state.dart';
import 'package:nocturne/domains/chat/widgets/match_tile.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
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
      await UnreadService.refresh();
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_matches.isEmpty) {
      return ChatEmptyState(
        icon: Icons.nightlight,
        message: AppLocalizations.of(context)!.chatEmptyMatchesTitle,
        sub: AppLocalizations.of(context)!.chatEmptyMatchesSub,
      );
    }
    return ListView.separated(
      itemCount: _matches.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Color(0xFF1A0A1F), height: 1),
      itemBuilder: (context, i) => MatchTile(
        match: _matches[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConversationPage(match: _matches[i]),
          ),
        ).then((_) => _load()),
      ),
    );
  }
}

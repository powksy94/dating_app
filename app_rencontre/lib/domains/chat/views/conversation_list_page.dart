import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/elegie/models/elegie.dart';
import 'package:nocturne/domains/chat/services/chat_service.dart';
import 'package:nocturne/domains/elegie/services/elegie_service.dart';
import 'package:nocturne/shared/services/unread_service.dart';
import 'package:nocturne/domains/chat/views/conversation_page.dart';

class ConversationListPage extends StatefulWidget {
  const ConversationListPage({super.key});

  @override
  State<ConversationListPage> createState() => _ConversationListPageState();
}

class _ConversationListPageState extends State<ConversationListPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF120018),
        title: Text(
          AppLocalizations.of(context)!.chatListTitle,
          style: const TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 16),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: const Color(0xFF7B00D4),
          indicatorWeight: 2,
          labelColor: const Color(0xFF7B00D4),
          unselectedLabelColor: const Color(0xFF5A4A6A),
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          tabs: [
            Tab(text: AppLocalizations.of(context)!.chatTabChats),
            Tab(text: AppLocalizations.of(context)!.chatTabElegiesReceived),
            Tab(text: AppLocalizations.of(context)!.chatTabElegiesSent),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ChatsTab(),
          _ElegiesReceivedTab(),
          _ElegiesSentTab(),
        ],
      ),
    );
  }
}

// ─── Onglet Chats ─────────────────────────────────────────────────────────────

class _ChatsTab extends StatefulWidget {
  const _ChatsTab();

  @override
  State<_ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<_ChatsTab> {
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
      return _EmptyState(
        icon: Icons.nightlight,
        message: AppLocalizations.of(context)!.chatEmptyMatchesTitle,
        sub: AppLocalizations.of(context)!.chatEmptyMatchesSub,
      );
    }
    return ListView.separated(
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
    );
  }
}

// ─── Onglet Élégies reçues ────────────────────────────────────────────────────

class _ElegiesReceivedTab extends StatefulWidget {
  const _ElegiesReceivedTab();
  @override
  State<_ElegiesReceivedTab> createState() => _ElegiesReceivedTabState();
}

class _ElegiesReceivedTabState extends State<_ElegiesReceivedTab> {
  List<Elegie> _elegies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final list = await ElegieService.getReceived();
      if (mounted) setState(() { _elegies = list; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_elegies.isEmpty) {
      return _EmptyState(
        icon: Icons.mail_outline,
        message: AppLocalizations.of(context)!.chatEmptyElegiesReceivedTitle,
        sub: AppLocalizations.of(context)!.chatEmptyElegiesReceivedSub,
      );
    }
    return ListView.separated(
      itemCount: _elegies.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Color(0xFF1A0A1F), height: 1),
      itemBuilder: (_, i) => _ElegieTile(elegie: _elegies[i]),
    );
  }
}

// ─── Onglet Élégies envoyées ──────────────────────────────────────────────────

class _ElegiesSentTab extends StatefulWidget {
  const _ElegiesSentTab();
  @override
  State<_ElegiesSentTab> createState() => _ElegiesSentTabState();
}

class _ElegiesSentTabState extends State<_ElegiesSentTab> {
  List<Elegie> _elegies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final list = await ElegieService.getSent();
      if (mounted) setState(() { _elegies = list; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_elegies.isEmpty) {
      return _EmptyState(
        icon: Icons.send_outlined,
        message: AppLocalizations.of(context)!.chatEmptyElegiesSentTitle,
        sub: AppLocalizations.of(context)!.chatEmptyElegiesSentSub,
      );
    }
    return ListView.separated(
      itemCount: _elegies.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Color(0xFF1A0A1F), height: 1),
      itemBuilder: (_, i) => _ElegieTile(elegie: _elegies[i]),
    );
  }
}

// ─── Widgets partagés ─────────────────────────────────────────────────────────

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

class _ElegieTile extends StatelessWidget {
  final Elegie elegie;
  const _ElegieTile({required this.elegie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xFF0D0010),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: const Color(0xFF2D0040),
        backgroundImage: elegie.otherAvatarUrl.isNotEmpty
            ? NetworkImage(elegie.otherAvatarUrl)
            : null,
        child: elegie.otherAvatarUrl.isEmpty
            ? const Icon(Icons.person, color: Color(0xFF7B00D4))
            : null,
      ),
      title: Text(
        elegie.otherUsername,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            elegie.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFAA9AB5),
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF7B00D4), width: 0.5),
        ),
        child: Text(
          AppLocalizations.of(context)!.chatElegiePending,
          style: const TextStyle(
            color: Color(0xFF7B00D4),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      isThreeLine: true,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String sub;
  const _EmptyState({required this.icon, required this.message, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: const Color(0xFF7B00D4)),
          const SizedBox(height: 16),
          Text(message,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16)),
          const SizedBox(height: 8),
          Text(sub,
              style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/chat_match.dart';
import '../models/elegie.dart';
import '../services/chat_service.dart';
import '../services/elegie_service.dart';
import 'conversation_page.dart';

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
        title: const Text(
          'MESSAGES',
          style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 16),
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
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'ÉLÉGIES REÇUES'),
            Tab(text: 'ÉLÉGIES ENVOYÉES'),
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
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_matches.isEmpty) {
      return const _EmptyState(
        icon: Icons.nightlight,
        message: 'Aucun match pour l\'instant...',
        sub: 'Continue d\'explorer les ténèbres',
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
      return const _EmptyState(
        icon: Icons.mail_outline,
        message: 'Aucune élégie reçue',
        sub: 'Quelqu\'un pensera à toi bientôt...',
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
      return const _EmptyState(
        icon: Icons.send_outlined,
        message: 'Aucune élégie envoyée',
        sub: 'Ose briser le silence...',
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
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}j';
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
        child: const Text(
          'En attente',
          style: TextStyle(
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

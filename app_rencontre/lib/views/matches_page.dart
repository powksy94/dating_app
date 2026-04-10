import 'package:flutter/material.dart';
import '../models/chat_match.dart';
import '../services/chat_service.dart';
import 'conversation_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'MES MATCHS',
          style: TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _matches.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: _matches.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Color(0xFF1A0A1F), height: 1),
                  itemBuilder: (context, index) =>
                      _MatchTile(match: _matches[index]),
                ),
    );
  }
}

class _MatchTile extends StatelessWidget {
  final ChatMatch match;
  const _MatchTile({required this.match});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF7B00D4), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7B00D4).withValues(alpha: 0.3),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipOval(
          child: match.avatarUrl.isNotEmpty
              ? Image.network(match.avatarUrl, fit: BoxFit.cover)
              : Container(
                  color: const Color(0xFF1A0A1F),
                  child: const Icon(Icons.person,
                      color: Color(0xFF7B00D4), size: 28),
                ),
        ),
      ),
      title: Text(
        match.username,
        style: const TextStyle(
          color: Color(0xFFE8E0EE),
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: const Text(
        'Liés par les ténèbres',
        style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
      ),
      trailing: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConversationPage(match: match),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A0072),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFF7B00D4)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Message',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
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
          Icon(Icons.people_outline, size: 64, color: Color(0xFF7B00D4)),
          SizedBox(height: 16),
          Text(
            'Aucun match pour l\'instant',
            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Continue à swiper pour trouver ta connexion obscure',
            style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

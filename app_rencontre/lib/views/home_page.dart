import 'package:flutter/material.dart';
import '../models/alternative_profile.dart';
import '../models/chat_match.dart';
import '../services/firestore_service.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_menu.dart';
import 'swipe_page.dart';
import 'conversation_list_page.dart';
import 'conversation_page.dart';
import 'events/events_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  void _navigateToConversation(ChatMatch match) {
    setState(() => _tab = 2);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ConversationPage(match: match)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          SwipePage(onNavigateToConversation: _navigateToConversation),
          const EventsPage(),
          const ConversationListPage(),
          const _MyProfileTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF120018),
        indicatorColor: const Color(0xFF7B00D4),
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.nightlight_outlined),
            selectedIcon: Icon(Icons.nightlight),
            label: 'Découvrir',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_activity_outlined),
            selectedIcon: Icon(Icons.local_activity),
            label: 'Événements',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ── Onglet Mon profil ──────────────────────────────────────────────────────────

class _MyProfileTab extends StatefulWidget {
  const _MyProfileTab();

  @override
  State<_MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<_MyProfileTab> {
  final _firestore = FirestoreService();
  AlternativeProfile? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    AlternativeProfile? profile;
    try {
      profile = await _firestore.getMyProfile();
    } catch (_) {}
    if (mounted) setState(() { _profile = profile; _loading = false; });
  }


  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ProfileMenu(
        onEdit: () {
          Navigator.pop(context);
          Navigator.pushNamed(
            context, '/edit-profile',
            arguments: _profile ?? AlternativeProfile(
              id: '', uid: '', username: '', avatarUrl: '', bio: '',
            ),
          ).then((_) => _loadProfile());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MON PROFIL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => _openMenu(context),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: _profile == null ? _noProfile(context) : _profileContent(context),
      ),
    );
  }

  Widget _noProfile(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_add,
              size: 64, color: Color(0xFF7B00D4)),
          const SizedBox(height: 16),
          const Text('Profil non configuré',
              style: TextStyle(color: Color(0xFFE8E0EE), fontSize: 18)),
          const SizedBox(height: 8),
          const Text('Crée ton profil pour apparaître dans le swipe',
              style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(
              context, '/edit-profile',
              arguments: AlternativeProfile(
                id: '', uid: '',
                username: '', avatarUrl: '', bio: '',
              ),
            ).then((_) => _loadProfile()),
            icon: const Icon(Icons.edit),
            label: const Text('Créer mon profil'),
          ),
        ],
      ),
    );
  }

  Widget _profileContent(BuildContext context) {
    final p = _profile!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile', arguments: p),
            child: ProfileCard(
              profile: p,
              onEdit: () => Navigator.pushNamed(
                context, '/edit-profile',
                arguments: p,
              ).then((_) => _loadProfile()),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/subscription'),
              icon: const Icon(Icons.auto_awesome, size: 18),
              label: const Text(
                'NOCTURNE PREMIUM',
                style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A0072),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: Color(0xFF7B00D4)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


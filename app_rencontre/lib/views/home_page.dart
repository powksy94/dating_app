import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/alternative_profile.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/profile_card.dart';
import 'swipe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const SwipePage(),
      const _EventsPlaceholder(),
      const _MyProfileTab(),
    ];

    return Scaffold(
      body: pages[_tab],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF120018),
        indicatorColor: const Color(0xFF7B00D4),
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.nightlight),
            selectedIcon: Icon(Icons.nightlight),
            label: 'Découvrir',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_activity),
            selectedIcon: Icon(Icons.local_activity),
            label: 'Événements',
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
  final _auth = AuthService();
  AlternativeProfile? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    AlternativeProfile? profile;
    try {
      profile = await _firestore.getProfile(uid);
    } catch (_) {
      // Firestore indisponible — profil mock pour le dev
      profile = AlternativeProfile(
        id: uid, uid: uid,
        username: 'Moi (mock)', avatarUrl: '', age: 25,
        bio: 'Profil de test — Firestore non connecté.',
        aesthetics: ['goth', 'dark academia'],
        musicGenres: ['darkwave'],
      );
    }
    if (mounted) setState(() { _profile = profile; _loading = false; });
  }

  Future<void> _logout() async {
    await _auth.logout();
    // authStateChanges dans app.dart redirige vers LoginPage
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
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: _logout,
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
                id: FirebaseAuth.instance.currentUser!.uid,
                uid: FirebaseAuth.instance.currentUser!.uid,
                username: '',
                avatarUrl: '',
                bio: '',
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
          ProfileCard(profile: p),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(
                context, '/edit-profile',
                arguments: p,
              ).then((_) => _loadProfile()),
              icon: const Icon(Icons.edit),
              label: const Text('Éditer mon profil'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Color(0xFF8B0000)),
              label: const Text('Se déconnecter',
                  style: TextStyle(color: Color(0xFF8B0000))),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF8B0000)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── Placeholder Événements ────────────────────────────────────────────────────

class _EventsPlaceholder extends StatelessWidget {
  const _EventsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event, size: 64, color: Color(0xFF7B00D4)),
            SizedBox(height: 12),
            Text('Événements à venir',
                style: TextStyle(color: Color(0xFFE8E0EE), fontSize: 20)),
            SizedBox(height: 8),
            Text('Bientôt disponible',
                style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

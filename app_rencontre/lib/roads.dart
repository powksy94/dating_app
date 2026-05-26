import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';
import 'views/profile_page.dart';
import 'views/profil_edit_page.dart';
import 'views/chat_page.dart';
import 'views/conversation_page.dart';
import 'models/alternative_profile.dart';
import 'models/chat_match.dart';
import 'services/chat_service.dart';
import 'views/register/register_flow.dart';
import 'views/subscription_page.dart';
import 'views/likes_history_page.dart';
import 'views/matches_page.dart';
import 'views/settings/settings_page.dart';
import 'views/admin_auth_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/profile':
        final profile = settings.arguments as AlternativeProfile;
        return MaterialPageRoute(builder: (_) => ProfilePage(profile: profile));
      case '/edit-profile':
        final profile = settings.arguments as AlternativeProfile;
        return MaterialPageRoute(builder: (_) => ProfileEditPage(profile: profile));
      case '/chat':
        final chatId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ChatPage(chatId: chatId));
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterFlow());
      case '/subscription':
        return MaterialPageRoute(builder: (_) => const SubscriptionPage());
      case '/likes-history':
        return MaterialPageRoute(builder: (_) => const LikesHistoryPage());
      case '/matches':
        return MaterialPageRoute(builder: (_) => const MatchesPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case '/conversation':
        final args    = settings.arguments as Map<String, dynamic>;
        final matchId = args['matchId'] as String;
        return MaterialPageRoute(
          builder: (_) => FutureBuilder<List<ChatMatch>>(
            future: ChatService.getMatches(),
            builder: (ctx, snap) {
              if (!snap.hasData) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              final match = snap.data!.firstWhere(
                (m) => m.matchId == matchId,
                orElse: () => ChatMatch(
                    matchId: matchId, userId: '', username: '', avatarUrl: ''),
              );
              return ConversationPage(match: match);
            },
          ),
        );
      case '/admin-auth':
        final sessionId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AdminAuthPage(sessionId: sessionId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page introuvable: ${settings.name}')),
          ),
        );
    }
  }
}

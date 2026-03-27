import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';
import 'views/profile_page.dart';
import 'views/profil_edit_page.dart';
import 'views/chat_page.dart';
import 'models/alternative_profile.dart';
import 'views/register/register_flow.dart';

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
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page introuvable: ${settings.name}')),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'profile_edit_page.dart';
import 'chat_page.dart';
import 'home_page.dart';
import 'models/gamer_profile.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/profile':
        final profile = settings.arguments as GamerProfile;
        return MaterialPageRoute(builder: (_) => ProfilePage(profile: profile));
      case '/edit-profile':
        final profile = settings.arguments as GamerProfile;
        return MaterialPageRoute(builder: (_) => ProfileEditPage(profile: profile));
      case '/chat':
        final chatId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ChatPage(chatId: chatId));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page introuvable: ${settings.name}')),
          ),
        );
    }
  }
}

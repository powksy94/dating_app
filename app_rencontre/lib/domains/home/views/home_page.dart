import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/shared/services/unread_service.dart';
import 'package:nocturne/domains/discovery/views/swipe_page.dart';
import 'package:nocturne/domains/chat/views/conversation_list_page.dart';
import 'package:nocturne/domains/chat/views/conversation_page.dart';
import 'package:nocturne/domains/event/views/events_page.dart';
import 'package:nocturne/domains/home/views/my_profile_tab.dart';
import 'package:nocturne/domains/home/widgets/exit_confirm_dialog.dart';
import 'package:nocturne/shared/widgets/common/requires_connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;
  final _swipeRefresh = ValueNotifier<int>(0);

  void _navigateToConversation(ChatMatch match) {
    setState(() => _tab = 2);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ConversationPage(match: match)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) confirmAppExit(context);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _tab,
          children: [
            RequiresConnection(
              pageTitle: l.discoverySwipePageTitle,
              child: SwipePage(onNavigateToConversation: _navigateToConversation, refreshNotifier: _swipeRefresh),
            ),
            const EventsPage(),
            RequiresConnection(
              pageTitle: l.chatListTitle,
              child: const ConversationListPage(),
            ),
            const MyProfileTab(),
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: UnreadService.unreadCount,
          builder: (context, unread, _) => NavigationBar(
            backgroundColor: const Color(0xFF120018),
            indicatorColor: const Color(0xFF7B00D4),
            selectedIndex: _tab,
            onDestinationSelected: (i) {
              if (i == 0 && _tab != 0) _swipeRefresh.value++;
              setState(() => _tab = i);
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.nightlight_outlined),
                selectedIcon: const Icon(Icons.nightlight),
                label: l.homeNavDiscover,
              ),
              NavigationDestination(
                icon: const Icon(Icons.local_activity_outlined),
                selectedIcon: const Icon(Icons.local_activity),
                label: l.homeNavEvents,
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: unread > 0,
                  label: Text(unread > 99 ? '99+' : '$unread'),
                  child: const Icon(Icons.chat_bubble_outline),
                ),
                selectedIcon: Badge(
                  isLabelVisible: unread > 0,
                  label: Text(unread > 99 ? '99+' : '$unread'),
                  child: const Icon(Icons.chat_bubble),
                ),
                label: l.homeNavMessages,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                label: l.homeNavProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

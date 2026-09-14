import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/views/chats_tab.dart';
import 'package:nocturne/domains/chat/views/elegies_received_tab.dart';
import 'package:nocturne/domains/chat/views/elegies_sent_tab.dart';

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
          ChatsTab(),
          ElegiesReceivedTab(),
          ElegiesSentTab(),
        ],
      ),
    );
  }
}

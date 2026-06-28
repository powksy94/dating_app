import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/widgets/my_likes_tab.dart';
import 'package:nocturne/domains/discovery/widgets/who_liked_me_tab.dart';

class LikesHistoryPage extends StatelessWidget {
  const LikesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0010),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.discoveryLikesTitle,
            style: const TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: const Color(0xFF7B00D4),
            labelColor: const Color(0xFFE8E0EE),
            unselectedLabelColor: const Color(0xFF6B5B7B),
            tabs: [
              Tab(text: AppLocalizations.of(context)!.discoveryTabMyLikes),
              Tab(text: AppLocalizations.of(context)!.discoveryTabWhoLikedMe),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyLikesTab(),
            WhoLikedMeTab(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
          title: const Text(
            'LIKES',
            style: TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color(0xFF7B00D4),
            labelColor: Color(0xFFE8E0EE),
            unselectedLabelColor: Color(0xFF6B5B7B),
            tabs: [
              Tab(text: 'Mes likes'),
              Tab(text: 'Qui m\'a liké'),
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

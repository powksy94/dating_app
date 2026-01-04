import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart'; // ou flutter_swiper selon ta dépendance
import 'models/gamer_profile.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  // Liste d'exemple, à remplacer par Firestore
  final List<GamerProfile> profiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gamer Dating App"),
        backgroundColor: Colors.black87,
      ),
      body: profiles.isEmpty
          ? const Center(child: Text("Aucun profil disponible", style: TextStyle(color: Colors.white70)))
          : Swiper(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/profile', arguments: profile),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          profile.avatarUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            profile.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              viewportFraction: 0.85,
              scale: 0.9,
              pagination: const SwiperPagination(),
            ),
    );
  }
}

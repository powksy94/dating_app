// lib/models/gamer_profile.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class GamerProfile {
  final String id;
  final String username;
  final String avatarUrl;
  final String bio;

  /// Map jeu -> { 'rank': 'Diamond 2', 'raw': {...} }
  final Map<String, Map<String, dynamic>> gameRanks;

  GamerProfile({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.gameRanks,
  });

  factory GamerProfile.fromFirestore(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return GamerProfile(
      id: snap.id,
      username: data['username'] ?? '',
      avatarUrl: data['avatarUrl'] ?? '',
      bio: data['bio'] ?? '',
      gameRanks: Map<String, Map<String, dynamic>>.from(
        (data['gameRanks'] ?? {}) as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'gameRanks': gameRanks,
    };
  }
}

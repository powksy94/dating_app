// lib/models/alternative_profile.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class AlternativeProfile {
  final String id;
  final String uid;
  final String username;
  final String avatarUrl;
  final String bio;
  final int? age;
  final String? pronouns;

  /// 1. Genres musicaux (gothic rock, darkwave, screamo...)
  final List<String> musicGenres;

  /// 2. Ambiance musicale (dark, melancholic, dreamy...)
  final List<String> musicVibes;

  /// 3. Esthétique / culture (goth, emo kid, punk DIY...)
  final List<String> aesthetics;

  /// 4. Intensité sonore (soft, intense, chaotic...)
  final List<String> soundIntensity;

  /// 5. Époque / scène (80s goth, 2000s emo, tumblr era...)
  final List<String> musicEras;

  /// 6. Format de découverte (concerts, vinyl collector...)
  final List<String> discoveryFormats;

  final List<String> favoriteBands;
  final List<String> upcomingEvents;
  final Map<String, String> socialLinks;

  AlternativeProfile({
    required this.id,
    required this.uid,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    this.age,
    this.pronouns,
    this.musicGenres      = const [],
    this.musicVibes       = const [],
    this.aesthetics       = const [],
    this.soundIntensity   = const [],
    this.musicEras        = const [],
    this.discoveryFormats = const [],
    this.favoriteBands    = const [],
    this.upcomingEvents   = const [],
    this.socialLinks      = const {},
  });

  factory AlternativeProfile.fromFirestore(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return AlternativeProfile(
      id:               snap.id,
      uid:              snap.id,
      username:         data['username']  ?? '',
      avatarUrl:        data['avatarUrl'] ?? '',
      bio:              data['bio']       ?? '',
      age:              data['age']       as int?,
      pronouns:         data['pronouns']  as String?,
      musicGenres:      List<String>.from(data['musicGenres']      ?? []),
      musicVibes:       List<String>.from(data['musicVibes']       ?? []),
      aesthetics:       List<String>.from(data['aesthetics']       ?? []),
      soundIntensity:   List<String>.from(data['soundIntensity']   ?? []),
      musicEras:        List<String>.from(data['musicEras']        ?? []),
      discoveryFormats: List<String>.from(data['discoveryFormats'] ?? []),
      favoriteBands:    List<String>.from(data['favoriteBands']    ?? []),
      upcomingEvents:   List<String>.from(data['upcomingEvents']   ?? []),
      socialLinks:      Map<String, String>.from(data['socialLinks'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() => {
    'username':         username,
    'avatarUrl':        avatarUrl,
    'bio':              bio,
    if (age != null)      'age':      age,
    if (pronouns != null) 'pronouns': pronouns,
    'musicGenres':      musicGenres,
    'musicVibes':       musicVibes,
    'aesthetics':       aesthetics,
    'soundIntensity':   soundIntensity,
    'musicEras':        musicEras,
    'discoveryFormats': discoveryFormats,
    'favoriteBands':    favoriteBands,
    'upcomingEvents':   upcomingEvents,
    'socialLinks':      socialLinks,
  };
}

// lib/models/alternative_profile.dart

int? _ageFromBirthDate(dynamic birthDate) {
  if (birthDate == null) return null;
  try {
    final birth = DateTime.parse(birthDate.toString());
    final now = DateTime.now();
    int age = now.year - birth.year;
    if (now.month < birth.month || (now.month == birth.month && now.day < birth.day)) age--;
    return age;
  } catch (_) {
    return null;
  }
}

class AlternativeProfile {
  final String id;
  final String uid;
  final String username;
  final String avatarUrl;
  final String bio;
  final int? age;
  final String? pronouns;

  final List<String> musicGenres;
  final List<String> musicVibes;
  final List<String> aesthetics;
  final List<String> soundIntensity;
  final List<String> musicEras;
  final List<String> discoveryFormats;
  final List<String> favoriteBands;
  final List<String> upcomingEvents;
  final Map<String, String> socialLinks;
  final List<String> photos;

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
    this.photos           = const [],
  });

  factory AlternativeProfile.fromJson(Map<String, dynamic> data) {
    return AlternativeProfile(
      id:               data['_id']       ?? '',
      uid:              data['owner']     ?? '',
      username:         data['username']  ?? '',
      avatarUrl:        data['avatarUrl'] ?? '',
      bio:              data['bio']       ?? '',
      age:              _ageFromBirthDate(data['birthDate']),
      pronouns:         data['pronouns']  as String?,
      musicGenres:      List<String>.from(data['musicsGenres']     ?? []),
      musicVibes:       List<String>.from(data['musicsVibes']      ?? []),
      aesthetics:       List<String>.from(data['aesthetics']       ?? []),
      soundIntensity:   List<String>.from(data['soundIntensity']   ?? []),
      musicEras:        List<String>.from(data['musicEras']        ?? []),
      discoveryFormats: List<String>.from(data['discoveryFormats'] ?? []),
      favoriteBands:    List<String>.from(data['favoriteBands']    ?? []),
      upcomingEvents:   List<String>.from(data['upcomingEvents']   ?? []),
      socialLinks:      Map<String, String>.from(data['socialLinks'] ?? {}),
      photos:           List<String>.from(data['photos']           ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
    'username':         username,
    'avatarUrl':        avatarUrl,
    'bio':              bio,
    if (age != null)      'age':      age,
    if (pronouns != null) 'pronouns': pronouns,
    'musicsGenres':     musicGenres,
    'musicsVibes':      musicVibes,
    'aesthetics':       aesthetics,
    'soundIntensity':   soundIntensity,
    'musicEras':        musicEras,
    'discoveryFormats': discoveryFormats,
    'favoriteBands':    favoriteBands,
    'upcomingEvents':   upcomingEvents,
    'socialLinks':      socialLinks,
    'photos':           photos,
  };
}

class LikedProfile {
  final String uid;
  final String username;
  final String avatarUrl;
  final List<String> photos;
  final int? age;
  final bool isMatch;

  LikedProfile({
    required this.uid,
    required this.username,
    required this.avatarUrl,
    required this.photos,
    required this.age,
    required this.isMatch,
  });

  factory LikedProfile.fromJson(Map<String, dynamic> json) => LikedProfile(
    uid:      json['uid'].toString(),
    username: json['username'] as String,
    avatarUrl: json['avatarUrl'] as String,
    photos:   List<String>.from(json['photos'] ?? []),
    age:      json['age'] as int?,
    isMatch:  json['isMatch'] as bool,
  );
}

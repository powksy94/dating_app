class Visitor {
  final String uid;
  final String username;
  final String avatarUrl;
  final List<String> photos;
  final int? age;
  final DateTime? visitedAt;

  Visitor({
    required this.uid,
    required this.username,
    required this.avatarUrl,
    required this.photos,
    this.age,
    this.visitedAt,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
    uid:       json['uid']?.toString() ?? '',
    username:  json['username'] as String? ?? '',
    avatarUrl: json['avatarUrl'] as String? ?? '',
    photos:    List<String>.from(json['photos'] ?? []),
    age:       json['age'] as int?,
    visitedAt: json['visitedAt'] != null ? DateTime.tryParse(json['visitedAt'].toString()) : null,
  );
}

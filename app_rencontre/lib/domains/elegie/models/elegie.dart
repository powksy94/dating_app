class Elegie {
  final String id;
  final String otherUserId;
  final String otherUsername;
  final String otherAvatarUrl;
  final String text;
  final String status;
  final DateTime createdAt;

  Elegie({
    required this.id,
    required this.otherUserId,
    required this.otherUsername,
    required this.otherAvatarUrl,
    required this.text,
    required this.status,
    required this.createdAt,
  });

  factory Elegie.fromReceivedJson(Map<String, dynamic> json) => Elegie(
    id:             json['id'].toString(),
    otherUserId:    json['fromId'].toString(),
    otherUsername:  json['fromUsername'] as String,
    otherAvatarUrl: json['fromAvatarUrl'] as String,
    text:           json['text'] as String,
    status:         json['status'] as String,
    createdAt:      DateTime.parse(json['createdAt'] as String),
  );

  factory Elegie.fromSentJson(Map<String, dynamic> json) => Elegie(
    id:             json['id'].toString(),
    otherUserId:    json['toId'].toString(),
    otherUsername:  json['toUsername'] as String,
    otherAvatarUrl: json['toAvatarUrl'] as String,
    text:           json['text'] as String,
    status:         json['status'] as String,
    createdAt:      DateTime.parse(json['createdAt'] as String),
  );
}

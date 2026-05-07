class ChatMatch {
  final String matchId;
  final String userId;
  final String username;
  final String avatarUrl;
  final String? lastMessageText;
  final DateTime? lastMessageAt;

  const ChatMatch({
    required this.matchId,
    required this.userId,
    required this.username,
    required this.avatarUrl,
    this.lastMessageText,
    this.lastMessageAt,
  });

  factory ChatMatch.fromJson(Map<String, dynamic> json) {
    final last = json['lastMessage'];
    return ChatMatch(
      matchId:         json['matchId'] as String,
      userId:          json['userId']  as String? ?? '',
      username:        json['username'] as String? ?? 'Inconnu',
      avatarUrl:       json['avatarUrl'] as String? ?? '',
      lastMessageText: last?['text'] as String?,
      lastMessageAt:   last != null
          ? DateTime.tryParse(last['createdAt'] as String? ?? '')
          : null,
    );
  }
}

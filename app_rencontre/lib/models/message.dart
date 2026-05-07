class ReplyTo {
  final String  id;
  final String  text;
  final String  sender;
  final String? imageUrl;

  const ReplyTo({
    required this.id,
    required this.text,
    required this.sender,
    this.imageUrl,
  });

  factory ReplyTo.fromJson(Map<String, dynamic> j) => ReplyTo(
    id:       j['id']?.toString()       ?? '',
    text:     j['text']?.toString()     ?? '',
    sender:   j['sender']?.toString()   ?? '',
    imageUrl: j['imageUrl']?.toString(),
  );

  bool get isImage => imageUrl != null && imageUrl!.isNotEmpty;
}

class Message {
    final String       id;
    final String       matchId;
    final String       sender;
    final String       text;
    final String?      imageUrl;
    final ReplyTo?     replyTo;
    final DateTime     createdAt;
    final bool         deletedForAll;
    final List<String> readBy;

    bool get isImage => imageUrl != null && imageUrl!.isNotEmpty;

    Message({
        required this.id,
        required this.matchId,
        required this.sender,
        required this.text,
        this.imageUrl,
        this.replyTo,
        required this.createdAt,
        this.deletedForAll = false,
        this.readBy        = const [],
    });

    bool isReadBy(String userId) => readBy.contains(userId);

    factory Message.fromJson(Map<String, dynamic> data) {
        return Message(
            id:            data['_id']          ?? '',
            matchId:       data['matchId']       ?? '',
            sender:        data['sender']        ?? '',
            text:          data['text']          ?? '',
            imageUrl:      data['imageUrl']      as String?,
            replyTo:       data['replyTo'] != null
                ? ReplyTo.fromJson(Map<String, dynamic>.from(data['replyTo']))
                : null,
            createdAt:     DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
            deletedForAll: data['deletedForAll'] ?? false,
            readBy:        List<String>.from(data['readBy'] ?? []),
        );
    }

    Message copyWith({bool? deletedForAll, List<String>? readBy}) => Message(
        id:            id,
        matchId:       matchId,
        sender:        sender,
        text:          text,
        imageUrl:      imageUrl,
        replyTo:       replyTo,
        createdAt:     createdAt,
        deletedForAll: deletedForAll ?? this.deletedForAll,
        readBy:        readBy        ?? this.readBy,
    );
}
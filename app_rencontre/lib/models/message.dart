class Message {
    final String   id;
    final String   matchId;
    final String   sender;
    final String   text;
    final DateTime createdAt;
    final bool     deletedForAll;

    Message({
        required this.id,
        required this.matchId,
        required this.sender,
        required this.text,
        required this.createdAt,
        this.deletedForAll = false,
    });

    factory Message.fromJson(Map<String, dynamic> data) {
        return Message(
            id:            data['_id']            ?? '',
            matchId:       data['matchId']         ?? '',
            sender:        data['sender']          ?? '',
            text:          data['text']            ?? '',
            createdAt:     DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
            deletedForAll: data['deletedForAll']   ?? false,
        );
    }

    Message copyWith({bool? deletedForAll}) => Message(
        id:            id,
        matchId:       matchId,
        sender:        sender,
        text:          text,
        createdAt:     createdAt,
        deletedForAll: deletedForAll ?? this.deletedForAll,
    );
}
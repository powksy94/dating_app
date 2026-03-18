class Message {
    final String id;
    final String matchId;
    final String sender;
    final String text;
    final DateTime createdAt;


    Message({
        required this.id,
        required this.matchId,
        required this.sender,
        required this.text,
        required this.createdAt,
    });

    factory Message.fromJson(Map<String, dynamic> data) {
        return Message(
            id:         data['_id']     ?? '',
            matchId:    data['matchId'] ?? '',
            sender:     data['sender']  ?? '',
            text:       data['text']    ?? '',
            createdAt:  DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
        );
    }
}
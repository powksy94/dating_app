import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:nocturne/shared/services/api_service.dart';

class SocketService {
  static final SocketService instance = SocketService._();
  SocketService._();

  io.Socket? _socket;

  bool get connected => _socket?.connected == true;

  Future<void> connect() async {
    if (connected) return;
    final token = await ApiService.getToken();
    _socket = io.io(
      'https://datingappbackend-production-a9e3.up.railway.app',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );
    _socket!.connect();
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void joinRoom(String matchId) =>
      _socket?.emit('join_room', matchId);

  void sendMessage(String matchId, String text, {
    String? imageUrl,
    String? audioUrl,
    Map<String, dynamic>? replyTo,
  }) =>
      _socket?.emit('send_message', {
        'matchId': matchId,
        'text':    text,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (audioUrl != null) 'audioUrl': audioUrl,
        if (replyTo != null)  'replyTo':  replyTo,
      });

  void emitTyping(String matchId) =>
      _socket?.emit('typing', matchId);

  void emitStopTyping(String matchId) =>
      _socket?.emit('stop_typing', matchId);

  void onNewMessage(void Function(Map<String, dynamic>) callback) {
    _socket?.on('new_message',
        (data) => callback(Map<String, dynamic>.from(data as Map)));
  }

  void onUserTyping(void Function(String) callback) {
    _socket?.on('user_typing', (data) => callback(data.toString()));
  }

  void onUserStopTyping(void Function(String) callback) {
    _socket?.on('user_stop_typing', (data) => callback(data.toString()));
  }

  void markRead(String matchId) =>
      _socket?.emit('mark_read', matchId);

  void onMessagesRead(void Function(String matchId, String readBy) callback) {
    _socket?.on('messages_read', (data) {
      final map = Map<String, dynamic>.from(data as Map);
      callback(map['matchId'].toString(), map['readBy'].toString());
    });
  }

  void reactMessage(String matchId, String messageId, String emoji) {
    _socket?.emit('react_message', {
      'matchId':   matchId,
      'messageId': messageId,
      'emoji':     emoji,
    });
  }

  void onMessageReacted(void Function(String messageId, Map<String, List<String>> reactions) callback) {
    _socket?.on('message_reacted', (data) {
      final map       = Map<String, dynamic>.from(data as Map);
      final messageId = map['messageId'].toString();
      final reactions = (map['reactions'] as Map<String, dynamic>? ?? {}).map(
        (k, v) => MapEntry(k, List<String>.from(v as List)),
      );
      callback(messageId, reactions);
    });
  }

  void emitDeleteForAll(String matchId, String messageId) {
    _socket?.emit('delete_message_for_all', {'matchId': matchId, 'messageId': messageId});
  }

  void onMessageDeletedForAll(void Function(String messageId) callback) {
    _socket?.on('message_deleted_for_all', (data) => callback(data.toString()));
  }

  void getOnlineStatus(String targetUserId) {
    _socket?.emit('get_online_status', targetUserId);
  }

  void onOnlineStatus(void Function(String userId, bool online, DateTime? lastSeen) callback) {
    _socket?.on('online_status', (data) {
      final map      = Map<String, dynamic>.from(data as Map);
      final userId   = map['userId'].toString();
      final online   = map['online'] as bool? ?? false;
      final lastSeen = map['lastSeen'] != null
          ? DateTime.tryParse(map['lastSeen'].toString())
          : null;
      callback(userId, online, lastSeen);
    });
  }

  void onUserOnline(void Function(String userId) callback) {
    _socket?.on('user_online', (data) => callback(data.toString()));
  }

  void onUserOffline(void Function(String userId, DateTime lastSeen) callback) {
    _socket?.on('user_offline', (data) {
      final map      = Map<String, dynamic>.from(data as Map);
      final userId   = map['userId'].toString();
      final lastSeen = DateTime.tryParse(map['lastSeen'].toString()) ?? DateTime.now();
      callback(userId, lastSeen);
    });
  }

  void off(String event) => _socket?.off(event);
}

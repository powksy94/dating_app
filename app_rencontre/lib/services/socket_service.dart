import 'package:socket_io_client/socket_io_client.dart' as io;
import 'api_service.dart';

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

  void sendMessage(String matchId, String text) =>
      _socket?.emit('send_message', {'matchId': matchId, 'text': text});

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

  void off(String event) => _socket?.off(event);
}

import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/shared/services/socket_service.dart';

/// Wires every socket event a conversation screen cares about to plain
/// callbacks, and owns unregistering them again — so the page doesn't have
/// to hand-maintain the same event-name list in two places (subscribe in
/// initState, unsubscribe in dispose).
class ConversationSocketController {
  final String matchId;
  final String otherId;
  final String? myId;

  ConversationSocketController({
    required this.matchId,
    required this.otherId,
    required this.myId,
  });

  void start({
    required void Function(Message message) onNewMessage,
    required void Function() onTyping,
    required void Function() onStopTyping,
    required void Function(bool online, DateTime? lastSeen) onOnlineStatus,
    required void Function() onUserOnline,
    required void Function(DateTime? lastSeen) onUserOffline,
    required void Function(String messageId, Map<String, List<String>> reactions) onMessageReacted,
    required void Function(String readBy) onMessagesRead,
    required void Function(String messageId) onMessageDeletedForAll,
  }) {
    SocketService.instance.onNewMessage((data) => onNewMessage(Message.fromJson(data)));
    SocketService.instance.onUserTyping((_) => onTyping());
    SocketService.instance.onUserStopTyping((_) => onStopTyping());
    SocketService.instance.onOnlineStatus((_, online, lastSeen) => onOnlineStatus(online, lastSeen));
    SocketService.instance.onUserOnline((uid) {
      if (uid != myId) onUserOnline();
    });
    SocketService.instance.onUserOffline((uid, lastSeen) {
      if (uid != myId) onUserOffline(lastSeen);
    });
    SocketService.instance.onMessageReacted(onMessageReacted);
    SocketService.instance.onMessagesRead((readMatchId, readBy) {
      if (readMatchId == matchId) onMessagesRead(readBy);
    });
    SocketService.instance.onMessageDeletedForAll(onMessageDeletedForAll);

    SocketService.instance.markRead(matchId);
    SocketService.instance.getOnlineStatus(otherId);
  }

  void dispose() {
    for (final e in [
      'new_message', 'user_typing', 'user_stop_typing',
      'online_status', 'user_online', 'user_offline',
      'message_reacted', 'messages_read', 'message_deleted_for_all',
    ]) {
      SocketService.instance.off(e);
    }
    SocketService.instance.emitStopTyping(matchId);
  }
}

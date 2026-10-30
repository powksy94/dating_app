import 'package:nocturne/domains/chat/models/message.dart';

/// Pure transformations applied to the message list in response to socket
/// events — kept out of the page so its socket callbacks are one-liners.
class MessageListOps {
  const MessageListOps._();

  static List<Message> withReaction(
    List<Message> messages, String messageId, Map<String, List<String>> reactions,
  ) =>
      messages.map((m) => m.id == messageId ? m.copyWith(reactions: reactions) : m).toList();

  static List<Message> withRead(List<Message> messages, String myId, String readBy) =>
      messages.map((m) =>
          m.sender == myId && !m.isReadBy(readBy) ? m.copyWith(readBy: [...m.readBy, readBy]) : m
      ).toList();

  static List<Message> withDeletedForAll(List<Message> messages, String messageId) =>
      messages.map((m) => m.id == messageId ? m.copyWith(deletedForAll: true) : m).toList();

  static List<Message> withReportedByMe(List<Message> messages, String messageId) =>
      messages.map((m) => m.id == messageId ? m.copyWith(reportedByMe: true) : m).toList();
}

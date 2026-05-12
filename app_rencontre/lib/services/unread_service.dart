import 'package:flutter/material.dart';
import 'chat_service.dart';

class UnreadService {
  static final unreadCount = ValueNotifier<int>(0);

  static Future<void> refresh() async {
    try {
      final matches = await ChatService.getMatches();
      final total = matches.fold(0, (sum, m) => sum + m.unreadCount);
      unreadCount.value = total;
    } catch (_) {}
  }
}

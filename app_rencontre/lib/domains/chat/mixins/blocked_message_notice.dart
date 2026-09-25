import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/services/socket_service.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

/// Handles a message the server refused (a link or a phone number before the
/// other person has replied): explains why, and puts the text back in the input
/// so the user can edit it instead of retyping it.
mixin BlockedMessageNotice<T extends StatefulWidget> on State<T> {
  String _lastSentText = '';

  /// Call each time a text message is sent.
  void rememberSentText(String text) => _lastSentText = text;

  /// Call once the socket listeners are set up.
  void listenForBlockedMessages(String matchId, TextEditingController input) {
    SocketService.instance.onMessageBlocked((blockedMatchId) {
      if (!mounted || blockedMatchId != matchId) return;
      if (input.text.isEmpty) {
        input.value = TextEditingValue(
          text: _lastSentText,
          selection: TextSelection.collapsed(offset: _lastSentText.length),
        );
      }
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.chatMessageBlockedContactInfo,
        backgroundColor: const Color(0xFF7F1D1D),
        duration: const Duration(seconds: 5),
      );
    });
  }
}

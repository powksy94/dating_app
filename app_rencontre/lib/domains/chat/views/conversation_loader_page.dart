import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/services/chat_service.dart';
import 'package:nocturne/domains/chat/views/conversation_page.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/shared/mixins/reload_on_reconnect.dart';
import 'package:nocturne/shared/widgets/common/load_error_view.dart';

/// Opens a conversation from its match id alone (e.g. from a notification).
/// The matches are loaded first, with a retry state instead of an endless
/// spinner when the request fails or times out.
class ConversationLoaderPage extends StatefulWidget {
  final String matchId;

  const ConversationLoaderPage({super.key, required this.matchId});

  @override
  State<ConversationLoaderPage> createState() => _ConversationLoaderPageState();
}

class _ConversationLoaderPageState extends State<ConversationLoaderPage>
    with ReloadOnReconnect<ConversationLoaderPage> {
  ChatMatch? _match;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  bool get needsReload => _failed;

  @override
  void reloadAfterReconnect() => _retry();

  void _retry() {
    setState(() => _failed = false);
    _load();
  }

  Future<void> _load() async {
    try {
      final matches = await ChatService.getMatches()
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      setState(() {
        _match = matches.firstWhere(
          (m) => m.matchId == widget.matchId,
          orElse: () => ChatMatch(
              matchId: widget.matchId, userId: '', username: '', avatarUrl: ''),
        );
      });
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final match = _match;
    if (match != null) return ConversationPage(match: match);

    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: _failed
          ? LoadErrorView(
              title:      l.chatOpenErrorTitle,
              subtitle:   l.commonLoadErrorSubtitle,
              retryLabel: l.commonBtnRetry,
              onRetry:    _retry,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

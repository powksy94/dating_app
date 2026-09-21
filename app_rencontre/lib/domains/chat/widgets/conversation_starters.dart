import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/models/starter_suggestion.dart';
import 'package:nocturne/domains/chat/services/chat_service.dart';
import 'package:nocturne/domains/chat/services/starter_texts.dart';
import 'package:nocturne/domains/chat/widgets/starter_option_tile.dart';

/// Shown in place of an empty conversation: ideas to start it, built from what
/// the two people really have in common. Tapping one asks for a confirmation
/// before [onSend] is called, so a stray tap never sends a message.
class ConversationStarters extends StatefulWidget {
  final String matchId;
  final ValueChanged<String> onSend;

  const ConversationStarters({super.key, required this.matchId, required this.onSend});

  @override
  State<ConversationStarters> createState() => _ConversationStartersState();
}

class _ConversationStartersState extends State<ConversationStarters> {
  StarterSuggestions? _result;
  bool _loading     = true;
  bool _showClassic = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await ChatService.getSuggestions(widget.matchId);
      if (!mounted) return;
      setState(() { _result = result; _loading = false; });
      if (!result.hasCommon) _showNoCommonDialog();
    } catch (_) {
      // No suggestions from the server: the classic icebreakers need none.
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showNoCommonDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final l = AppLocalizations.of(context)!;
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1A0A1F),
          content: Text(l.starterNoCommonDialog, style: const TextStyle(color: Color(0xFFAA9AB5))),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.commonBtnOk))],
        ),
      );
    });
  }

  Future<void> _confirmAndSend(String message) async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A0A1F),
        title: Text(l.starterConfirmTitle, style: const TextStyle(color: Colors.white, fontSize: 16)),
        content: Text(message, style: const TextStyle(color: Color(0xFFE8E0EE))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.commonBtnCancel)),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.commonBtnSend)),
        ],
      ),
    );
    if (confirmed == true) widget.onSend(message);
  }

  List<StarterText> _items(AppLocalizations l) {
    final result = _result;
    if (!_showClassic && result != null && result.source != 'none') {
      final shared = result.suggestions.map((s) => starterText(l, s)).whereType<StarterText>().toList();
      // Every id unknown to this build would leave nothing to show: classic ones then.
      if (shared.isNotEmpty) return shared;
    }
    return classicStarterTexts(l);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    final l = AppLocalizations.of(context)!;
    // The toggle only makes sense when there is a common ground to switch away from.
    final canToggle = _result?.source == 'common';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.starterCardTitle,
                  style: const TextStyle(
                    color: Color(0xFFAA9AB5),
                    fontSize: 13,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (canToggle)
                Flexible(
                  child: TextButton(
                    onPressed: () => setState(() => _showClassic = !_showClassic),
                    child: Text(
                      _showClassic ? l.starterToggleShared : l.starterToggleClassic,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          for (final item in _items(l))
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StarterOptionTile(text: item, onTap: () => _confirmAndSend(item.message)),
            ),
        ],
      ),
    );
  }
}

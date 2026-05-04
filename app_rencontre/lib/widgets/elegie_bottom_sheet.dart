import 'package:flutter/material.dart';
import '../models/alternative_profile.dart';
import '../models/chat_match.dart';
import '../services/elegie_service.dart';
import '../widgets/match/match_overlay.dart';

void showElegieBottomSheet(
  BuildContext context,
  AlternativeProfile profile,
  void Function(ChatMatch)? onNavigateToConversation,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1A0A1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _ElegieSheet(
      profile: profile,
      pageContext: context,
      onNavigateToConversation: onNavigateToConversation,
    ),
  );
}

class _ElegieSheet extends StatefulWidget {
  final AlternativeProfile profile;
  final BuildContext pageContext;
  final void Function(ChatMatch)? onNavigateToConversation;
  const _ElegieSheet({
    required this.profile,
    required this.pageContext,
    this.onNavigateToConversation,
  });

  @override
  State<_ElegieSheet> createState() => _ElegieSheetState();
}

class _ElegieSheetState extends State<_ElegieSheet> {
  final _ctrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    try {
      final matchId = await ElegieService.sendElegie(widget.profile.uid, text);
      if (!mounted) return;
      Navigator.pop(context);
      if (matchId != null) {
        // Match déclenché par l'élégie → animation + navigation conversation
        final chatMatch = ChatMatch(
          matchId:  matchId,
          username: widget.profile.username,
          avatarUrl: widget.profile.avatarUrl,
        );
        Navigator.push(
          widget.pageContext,
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => MatchOverlay(
              matchedProfile: widget.profile,
              myAvatarUrl: null,
              isElegieMatch: true,
              elegieText: text,
              onMessage: () => widget.onNavigateToConversation?.call(chatMatch),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(widget.pageContext).showSnackBar(
          SnackBar(
            content: Text('Élégie envoyée à ${widget.profile.username}'),
            backgroundColor: const Color(0xFF4A0072),
          ),
        );
      }
    } catch (_) {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardBottom = MediaQuery.of(context).viewInsets.bottom;
    final systemBottom   = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, keyboardBottom + systemBottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF3D2A4A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Titre
          Row(
            children: [
              const Icon(Icons.edit_note, color: Color(0xFF7B00D4), size: 22),
              const SizedBox(width: 8),
              Text(
                'Élégie pour ${widget.profile.username}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Un court message avant que les ténèbres décident',
            style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
          ),
          const SizedBox(height: 16),

          // Champ texte
          ValueListenableBuilder(
            valueListenable: _ctrl,
            builder: (context, value, _) {
              final count = value.text.length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _ctrl,
                    maxLength: 200,
                    maxLines: 4,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Écris ton message...',
                      hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
                      filled: true,
                      fillColor: const Color(0xFF0D0010),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF3D2A4A)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF7B00D4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF3D2A4A)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$count / 200',
                    style: TextStyle(
                      color: count > 180
                          ? const Color(0xFFD400FF)
                          : const Color(0xFF5A4A6A),
                      fontSize: 11,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Bouton envoyer
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _sending ? null : _send,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                disabledBackgroundColor: const Color(0xFF3D2A4A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _sending
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Envoyer l\'élégie',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/chat/models/message.dart';

const _kQuickEmojis = ['🖤', '❤️', '😭', '🔥', '💀', '✨', '🦇', '🌙'];

void showMessageOptionsSheet(
  BuildContext context,
  Message message,
  bool isMe, {
  required void Function(String emoji) onReact,
  required VoidCallback onDeleteForMe,
  required VoidCallback onDeleteForAll,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A0A1F),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _MessageOptionsSheet(
      message:       message,
      isMe:          isMe,
      onReact:       onReact,
      onDeleteForMe: onDeleteForMe,
      onDeleteForAll: onDeleteForAll,
    ),
  );
}

class _MessageOptionsSheet extends StatefulWidget {
  final Message  message;
  final bool     isMe;
  final void Function(String) onReact;
  final VoidCallback onDeleteForMe;
  final VoidCallback onDeleteForAll;

  const _MessageOptionsSheet({
    required this.message,
    required this.isMe,
    required this.onReact,
    required this.onDeleteForMe,
    required this.onDeleteForAll,
  });

  @override
  State<_MessageOptionsSheet> createState() => _MessageOptionsSheetState();
}

class _MessageOptionsSheetState extends State<_MessageOptionsSheet> {
  bool _showEmojiField = false;
  final _emojiCtrl = TextEditingController();

  @override
  void dispose() {
    _emojiCtrl.dispose();
    super.dispose();
  }

  void _react(String emoji) {
    Navigator.pop(context);
    widget.onReact(emoji);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFF3D2A4A),
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),

            // ── Quick emojis ────────────────────────────────────────────────
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  ..._kQuickEmojis.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => _react(e),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D0040),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(e, style: const TextStyle(fontSize: 22)),
                      ),
                    ),
                  )),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => setState(() => _showEmojiField = true),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D0040),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFF3D2A4A)),
                      ),
                      child: const Icon(Icons.add,
                          size: 22, color: Color(0xFF5A4A6A)),
                    ),
                  ),
                ],
              ),
            ),

            // ── Champ emoji natif ───────────────────────────────────────────
            if (_showEmojiField) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _emojiCtrl,
                  autofocus: true,
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                  maxLength: 2,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.chatEmojiHint,
                    hintStyle: const TextStyle(
                        color: Color(0xFF5A4A6A), fontSize: 14),
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFF0D0010),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF7B00D4))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF7B00D4))),
                  ),
                  onChanged: (val) {
                    final runes = val.runes.toList();
                    if (runes.isNotEmpty) {
                      final emoji = String.fromCharCodes(
                          runes.take(2));
                      _react(emoji);
                    }
                  },
                ),
              ),
            ],

            const Divider(color: Color(0xFF2D0040), height: 24),

            // ── Options suppression ─────────────────────────────────────────
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Color(0xFFAA9AB5)),
              title: Text(AppLocalizations.of(context)!.chatBtnDeleteForMe,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                widget.onDeleteForMe();
              },
            ),
            if (widget.isMe && !widget.message.deletedForAll)
              ListTile(
                leading: const Icon(Icons.delete_forever,
                    color: Color(0xFF8B0000)),
                title: Text(AppLocalizations.of(context)!.chatBtnDeleteForAll,
                    style: const TextStyle(color: Color(0xFF8B0000))),
                onTap: () {
                  Navigator.pop(context);
                  widget.onDeleteForAll();
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

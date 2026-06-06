import 'package:flutter/material.dart';
import 'package:nocturne/domains/social/services/user_action_service.dart';
import 'package:nocturne/domains/social/widgets/report_reason_tree.dart';

void showReportFlow(
  BuildContext context, {
  required String userId,
  required String username,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A0A1F),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ReportFlow(userId: userId, username: username),
  );
}

class _ReportFlow extends StatefulWidget {
  final String userId;
  final String username;
  const _ReportFlow({required this.userId, required this.username});

  @override
  State<_ReportFlow> createState() => _ReportFlowState();
}

class _ReportFlowState extends State<_ReportFlow> {
  ReportCategory? _selected;
  final _textCtrl = TextEditingController();
  bool _sending   = false;
  bool _done      = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(String reason) async {
    setState(() => _sending = true);
    await UserActionService.reportUser(widget.userId, reason);
    if (mounted) setState(() { _sending = false; _done = true; });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _done
              ? _doneView()
              : _selected == null
                  ? _rootView()
                  : _selected!.hasSubs
                      ? _subsView()
                      : _textFieldView(),
        ),
      ),
    );
  }

  Widget _header({bool showBack = false}) => Column(
    children: [
      const SizedBox(height: 8),
      Row(
        children: [
          if (showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 16, color: Color(0xFF5A4A6A)),
              onPressed: () => setState(() => _selected = null),
            )
          else
            const SizedBox(width: 16),
          Expanded(
            child: Text(
              showBack ? _selected!.label : 'Signaler ${widget.username}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close,
                size: 18, color: Color(0xFF5A4A6A)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      const Divider(color: Color(0xFF2D0040), height: 1),
    ],
  );

  Widget _rootView() => Column(
    key: const ValueKey('root'),
    mainAxisSize: MainAxisSize.min,
    children: [
      _header(),
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(
          'Pourquoi signales-tu ce profil ?',
          style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
        ),
      ),
      ...kReportTree.map((cat) => ListTile(
        title: Text(cat.label,
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        trailing: cat.isLeaf
            ? null
            : const Icon(Icons.chevron_right,
                color: Color(0xFF5A4A6A), size: 18),
        onTap: () => cat.isLeaf
            ? _submit(cat.label)
            : setState(() => _selected = cat),
      )),
      const SizedBox(height: 8),
    ],
  );

  Widget _subsView() => Column(
    key: const ValueKey('subs'),
    mainAxisSize: MainAxisSize.min,
    children: [
      _header(showBack: true),
      const SizedBox(height: 4),
      ..._selected!.subs.map((sub) => ListTile(
        title: Text(sub,
            style: const TextStyle(color: Colors.white, fontSize: 14)),
        onTap: () => _submit('${_selected!.label} — $sub'),
      )),
      const SizedBox(height: 8),
    ],
  );

  Widget _textFieldView() => Column(
    key: const ValueKey('text'),
    mainAxisSize: MainAxisSize.min,
    children: [
      _header(showBack: true),
      Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _textCtrl,
          autofocus: true,
          maxLines: 3,
          maxLength: 300,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Décris le problème...',
            hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
            filled: true,
            fillColor: const Color(0xFF0D0010),
            counterStyle: const TextStyle(
                color: Color(0xFF5A4A6A), fontSize: 11),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF7B00D4))),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _sending ? null : () {
              final t = _textCtrl.text.trim();
              if (t.isEmpty) return;
              _submit('Autre — $t');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B00D4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: _sending
                ? const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2)
                : const Text('Envoyer le signalement',
                    style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );

  Widget _doneView() => Column(
    key: const ValueKey('done'),
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 32),
      const Icon(Icons.check_circle_outline,
          color: Color(0xFF7B00D4), size: 56),
      const SizedBox(height: 16),
      const Text('Signalement envoyé',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          'Merci. Notre équipe va examiner ce signalement.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 13),
        ),
      ),
      const SizedBox(height: 24),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Fermer',
            style: TextStyle(color: Color(0xFF7B00D4))),
      ),
      const SizedBox(height: 16),
    ],
  );
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/chat_match.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../services/api_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_bar.dart';

class ConversationPage extends StatefulWidget {
  final ChatMatch match;
  const ConversationPage({super.key, required this.match});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _ctrl   = TextEditingController();
  final _scroll = ScrollController();
  List<Message> _messages = [];
  bool _loading = true;
  String? _myId;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _myId = await ApiService.getUserId();
    await _loadMessages();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _loadMessages(silent: true),
    );
  }

  Future<void> _loadMessages({bool silent = false}) async {
    try {
      final msgs = await ChatService.getMessages(widget.match.matchId);
      if (mounted) {
        setState(() {
          _messages = msgs;
          if (!silent) _loading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scroll.hasClients) {
            _scroll.animateTo(
              _scroll.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } catch (_) {
      if (mounted && !silent) setState(() => _loading = false);
    }
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();
    await ChatService.sendMessage(widget.match.matchId, text);
    await _loadMessages(silent: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF120018),
        toolbarHeight: 72,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFF2D0040),
              backgroundImage: widget.match.avatarUrl.isNotEmpty
                  ? NetworkImage(widget.match.avatarUrl)
                  : null,
              child: widget.match.avatarUrl.isEmpty
                  ? const Icon(Icons.person, color: Color(0xFF7B00D4), size: 18)
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              widget.match.username,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    itemCount: _messages.length,
                    itemBuilder: (context, i) => MessageBubble(
                      message: _messages[i],
                      isMe: _messages[i].sender == _myId,
                    ),
                  ),
                ),
                ChatInputBar(ctrl: _ctrl, onSend: _send),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/chat_match.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../services/api_service.dart';
import '../services/socket_service.dart';
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
  List<Message> _messages    = [];
  bool   _loading            = true;
  bool   _otherTyping        = false;
  String? _myId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _myId = await ApiService.getUserId();
    await _loadMessages();
    await SocketService.instance.connect();
    SocketService.instance.joinRoom(widget.match.matchId);
    _setupSocketListeners();
  }

  void _setupSocketListeners() {
    SocketService.instance.onNewMessage((data) {
      final msg = Message.fromJson(data);
      if (mounted) {
        setState(() => _messages.add(msg));
        _scrollToBottom();
      }
    });

    SocketService.instance.onUserTyping((_) {
      if (mounted) setState(() => _otherTyping = true);
    });

    SocketService.instance.onUserStopTyping((_) {
      if (mounted) setState(() => _otherTyping = false);
    });
  }

  Future<void> _loadMessages() async {
    try {
      final msgs = await ChatService.getMessages(widget.match.matchId);
      if (mounted) {
        setState(() { _messages = msgs; _loading = false; });
        _scrollToBottom();
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _scrollToBottom() {
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

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    _ctrl.clear();
    SocketService.instance.emitStopTyping(widget.match.matchId);
    SocketService.instance.sendMessage(widget.match.matchId, text);
  }

  bool _wasTyping = false;

  void _onTypingChanged() {
    final typing = _ctrl.text.isNotEmpty;
    if (typing == _wasTyping) return;
    _wasTyping = typing;
    if (typing) {
      SocketService.instance.emitTyping(widget.match.matchId);
    } else {
      SocketService.instance.emitStopTyping(widget.match.matchId);
    }
  }

  @override
  void dispose() {
    SocketService.instance.off('new_message');
    SocketService.instance.off('user_typing');
    SocketService.instance.off('user_stop_typing');
    SocketService.instance.emitStopTyping(widget.match.matchId);
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
                  ? const Icon(Icons.person,
                      color: Color(0xFF7B00D4), size: 18)
                  : null,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.match.username,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16)),
                if (_otherTyping)
                  const Text('en train d\'écrire...',
                      style: TextStyle(
                          color: Color(0xFF7B00D4),
                          fontSize: 12,
                          fontStyle: FontStyle.italic)),
              ],
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
                ChatInputBar(
                  ctrl: _ctrl,
                  onSend: _send,
                  onChanged: (_) => _onTypingChanged(),
                ),
              ],
            ),
    );
  }
}

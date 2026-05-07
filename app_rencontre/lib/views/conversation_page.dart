import 'package:flutter/material.dart';
import '../models/chat_match.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../services/api_service.dart';
import '../services/socket_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_bar.dart';

void _showDeleteSheet(BuildContext context, Message message, bool isMe, {
  required VoidCallback onDeleteForMe,
  required VoidCallback onDeleteForAll,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A0A1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4,
              decoration: BoxDecoration(color: const Color(0xFF3D2A4A),
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Color(0xFFAA9AB5)),
            title: const Text('Supprimer pour moi',
                style: TextStyle(color: Colors.white)),
            onTap: () { Navigator.pop(context); onDeleteForMe(); },
          ),
          if (isMe && !message.deletedForAll)
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Color(0xFF8B0000)),
              title: const Text('Supprimer pour tout le monde',
                  style: TextStyle(color: Color(0xFF8B0000))),
              onTap: () { Navigator.pop(context); onDeleteForAll(); },
            ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

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
  bool      _loading      = true;
  bool      _otherTyping  = false;
  bool      _otherOnline  = false;
  DateTime? _otherLastSeen;
  String?   _myId;

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

    SocketService.instance.onOnlineStatus((userId, online, lastSeen) {
      if (mounted) setState(() {
        _otherOnline   = online;
        _otherLastSeen = lastSeen;
      });
    });

    SocketService.instance.onMessageDeletedForAll((messageId) {
      if (mounted) {
        setState(() {
          _messages = _messages.map((m) =>
              m.id == messageId ? m.copyWith(deletedForAll: true) : m
          ).toList();
        });
      }
    });

    SocketService.instance.onUserOnline((userId) {
      if (userId != _myId && mounted) setState(() => _otherOnline = true);
    });

    SocketService.instance.onUserOffline((userId, lastSeen) {
      if (userId != _myId && mounted) {
        setState(() {
          _otherOnline   = false;
          _otherLastSeen = lastSeen;
        });
      }
    });

    SocketService.instance.getOnlineStatus(widget.match.userId);
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

  Future<void> _deleteForMe(Message msg) async {
    await ChatService.deleteForMe(msg.id);
    if (mounted) setState(() => _messages.removeWhere((m) => m.id == msg.id));
  }

  Future<void> _deleteForAll(Message msg) async {
    SocketService.instance.emitDeleteForAll(widget.match.matchId, msg.id);
  }

  bool _wasTyping = false;

  String _lastSeenText() {
    if (_otherLastSeen == null) return '';
    final diff = DateTime.now().difference(_otherLastSeen!);
    if (diff.inMinutes < 1)  return 'vu à l\'instant';
    if (diff.inMinutes < 60) return 'vu il y a ${diff.inMinutes} min';
    if (diff.inHours < 24)   return 'vu il y a ${diff.inHours} h';
    return 'vu il y a ${diff.inDays} j';
  }

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
    SocketService.instance.off('online_status');
    SocketService.instance.off('user_online');
    SocketService.instance.off('user_offline');
    SocketService.instance.off('message_deleted_for_all');
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
                Row(
                  children: [
                    Text(widget.match.username,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16)),
                    if (_otherOnline) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 8, height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ECC71),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                if (_otherTyping)
                  const Text('en train d\'écrire...',
                      style: TextStyle(
                          color: Color(0xFF7B00D4),
                          fontSize: 12,
                          fontStyle: FontStyle.italic))
                else if (!_otherOnline && _otherLastSeen != null)
                  Text(_lastSeenText(),
                      style: const TextStyle(
                          color: Color(0xFF5A4A6A), fontSize: 11)),
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
                      onLongPress: (msg, isMe) => _showDeleteSheet(
                        context, msg, isMe,
                        onDeleteForMe:  () => _deleteForMe(msg),
                        onDeleteForAll: () => _deleteForAll(msg),
                      ),
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../models/chat_match.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../services/api_service.dart';
import '../services/socket_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat/chat_app_bar.dart';
import '../widgets/chat/reply_bar.dart';
import '../widgets/chat/message_options_sheet.dart';

class ConversationPage extends StatefulWidget {
  final ChatMatch match;
  const ConversationPage({super.key, required this.match});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _ctrl   = TextEditingController();
  final _scroll = ScrollController();

  List<Message> _messages      = [];
  bool          _loading       = true;
  bool          _otherTyping   = false;
  bool          _otherOnline   = false;
  DateTime?     _otherLastSeen;
  String?       _myId;
  Message?      _replyingTo;
  bool          _wasTyping     = false;
  bool          _isRecording   = false;
  final _recorder = AudioRecorder();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    _myId = await ApiService.getUserId();
    await _loadMessages();
    await SocketService.instance.connect();
    SocketService.instance.joinRoom(widget.match.matchId);
    _setupListeners();
  }

  void _setupListeners() {
    SocketService.instance.onNewMessage((data) {
      if (mounted) {
        setState(() => _messages.add(Message.fromJson(data)));
        _scrollToBottom();
      }
    });
    SocketService.instance.onUserTyping((_) {
      if (mounted) { setState(() => _otherTyping = true); }
    });
    SocketService.instance.onUserStopTyping((_) {
      if (mounted) { setState(() => _otherTyping = false); }
    });
    SocketService.instance.onOnlineStatus((_, online, lastSeen) {
      if (mounted) {
        setState(() { _otherOnline = online; _otherLastSeen = lastSeen; });
      }
    });
    SocketService.instance.onUserOnline((uid) {
      if (uid != _myId && mounted) { setState(() => _otherOnline = true); }
    });
    SocketService.instance.onUserOffline((uid, lastSeen) {
      if (uid != _myId && mounted) {
        setState(() { _otherOnline = false; _otherLastSeen = lastSeen; });
      }
    });
    SocketService.instance.onMessageReacted((msgId, reactions) {
      if (mounted) {
        setState(() {
          _messages = _messages.map((m) =>
              m.id == msgId ? m.copyWith(reactions: reactions) : m).toList();
        });
      }
    });
    SocketService.instance.onMessagesRead((matchId, readBy) {
      if (mounted && matchId == widget.match.matchId) {
        setState(() {
          _messages = _messages.map((m) =>
            m.sender == _myId && !m.isReadBy(readBy)
                ? m.copyWith(readBy: [...m.readBy, readBy]) : m
          ).toList();
        });
      }
    });
    SocketService.instance.onMessageDeletedForAll((msgId) {
      if (mounted) {
        setState(() {
          _messages = _messages.map((m) =>
              m.id == msgId ? m.copyWith(deletedForAll: true) : m).toList();
        });
      }
    });
    SocketService.instance.markRead(widget.match.matchId);
    SocketService.instance.getOnlineStatus(widget.match.userId);
  }

  Future<void> _loadMessages() async {
    try {
      final msgs = await ChatService.getMessages(widget.match.matchId);
      if (mounted) { setState(() { _messages = msgs; _loading = false; }); _scrollToBottom(); }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
      }
    });
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty && _replyingTo == null) return;
    _ctrl.clear();
    SocketService.instance.emitStopTyping(widget.match.matchId);
    SocketService.instance.sendMessage(widget.match.matchId, text,
      replyTo: _replyingTo != null ? {
        'id': _replyingTo!.id, 'text': _replyingTo!.text, 'sender': _replyingTo!.sender,
        if (_replyingTo!.imageUrl != null) 'imageUrl': _replyingTo!.imageUrl,
      } : null,
    );
    if (mounted) setState(() => _replyingTo = null);
  }

  void _onTypingChanged() {
    final typing = _ctrl.text.isNotEmpty;
    if (typing == _wasTyping) return;
    _wasTyping = typing;
    typing
        ? SocketService.instance.emitTyping(widget.match.matchId)
        : SocketService.instance.emitStopTyping(widget.match.matchId);
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _recorder.stop();
      setState(() => _isRecording = false);
      if (path == null || !mounted) return;
      final url = await ChatService.uploadChatAudio(path);
      if (url == null || !mounted) return;
      SocketService.instance.sendMessage(widget.match.matchId, '', audioUrl: url);
    } else {
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) return;
      final dir  = await getTemporaryDirectory();
      final path = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(const RecordConfig(), path: path);
      if (mounted) setState(() => _isRecording = true);
    }
  }

  Future<void> _pickAndSendImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null) return;
    final url = await ChatService.uploadChatImage(img.path);
    if (url == null || !mounted) return;
    SocketService.instance.sendMessage(widget.match.matchId, '', imageUrl: url);
  }

  Future<void> _deleteForMe(Message msg) async {
    await ChatService.deleteForMe(msg.id);
    if (mounted) setState(() => _messages.removeWhere((m) => m.id == msg.id));
  }

  void _deleteForAll(Message msg) =>
      SocketService.instance.emitDeleteForAll(widget.match.matchId, msg.id);

  String _lastSeenText() {
    if (_otherLastSeen == null) return '';
    final diff = DateTime.now().difference(_otherLastSeen!);
    if (diff.inMinutes < 1)  return 'vu à l\'instant';
    if (diff.inMinutes < 60) return 'vu il y a ${diff.inMinutes} min';
    if (diff.inHours < 24)   return 'vu il y a ${diff.inHours} h';
    return 'vu il y a ${diff.inDays} j';
  }

  @override
  void dispose() {
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    for (final e in ['new_message', 'user_typing', 'user_stop_typing',
        'online_status', 'user_online', 'user_offline',
        'message_reacted', 'messages_read', 'message_deleted_for_all']) {
      SocketService.instance.off(e);
    }
    SocketService.instance.emitStopTyping(widget.match.matchId);
    _recorder.dispose();
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: ChatAppBar(
        match:        widget.match,
        otherOnline:  _otherOnline,
        otherTyping:  _otherTyping,
        lastSeenText: _otherOnline ? null : _lastSeenText(),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: _messages.length,
                    itemBuilder: (context, i) {
                      final msg        = _messages[i];
                      final isMe       = msg.sender == _myId;
                      final isLastMine = isMe &&
                          _messages.lastIndexWhere((m) => m.sender == _myId) == i;
                      return MessageBubble(
                        message:         msg,
                        isMe:            isMe,
                        showReadReceipt: isLastMine,
                        otherId:         widget.match.userId,
                        onSwipeReply:    (m) => setState(() => _replyingTo = m),
                        onLongPress:     (m, me) => showMessageOptionsSheet(
                          context, m, me,
                          onReact:        (emoji) => SocketService.instance
                              .reactMessage(widget.match.matchId, m.id, emoji),
                          onDeleteForMe:  () => _deleteForMe(m),
                          onDeleteForAll: () => _deleteForAll(m),
                        ),
                      );
                    },
                  ),
                ),
                if (_replyingTo != null)
                  ReplyBar(
                    replyingTo: _replyingTo!,
                    onCancel:   () => setState(() => _replyingTo = null),
                  ),
                ChatInputBar(
                  ctrl:        _ctrl,
                  onSend:      _send,
                  onImagePick: _pickAndSendImage,
                  onMicPress:  _toggleRecording,
                  isRecording: _isRecording,
                  onChanged:   (_) => _onTypingChanged(),
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/chat/models/message.dart';
import 'package:nocturne/domains/chat/services/chat_service.dart';
import 'package:nocturne/domains/chat/services/conversation_actions.dart';
import 'package:nocturne/domains/chat/services/conversation_socket_controller.dart';
import 'package:nocturne/domains/chat/mixins/blocked_message_notice.dart';
import 'package:nocturne/domains/chat/utils/message_list_ops.dart';
import 'package:nocturne/shared/services/api_service.dart';
import 'package:nocturne/shared/services/socket_service.dart';
import 'package:nocturne/shared/widgets/common/requires_connection.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';
import 'package:nocturne/domains/chat/widgets/conversation_scaffold.dart';

class ConversationPage extends StatefulWidget {
  final ChatMatch match;
  const ConversationPage({super.key, required this.match});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> with BlockedMessageNotice {
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

  late final ConversationActions _actions = ConversationActions(matchId: widget.match.matchId);
  late final ConversationSocketController _socketController;

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
    _socketController = ConversationSocketController(
      matchId: widget.match.matchId,
      otherId: widget.match.userId,
      myId:    _myId,
    )..start(
        onNewMessage: (msg) {
          if (mounted && (msg.text.isNotEmpty || msg.isImage || msg.isAudio)) {
            setState(() => _messages.add(msg));
            _scrollToBottom();
          }
        },
        onTyping:     () { if (mounted) setState(() => _otherTyping = true); },
        onStopTyping: () { if (mounted) setState(() => _otherTyping = false); },
        onOnlineStatus: (online, lastSeen) {
          if (mounted) setState(() { _otherOnline = online; _otherLastSeen = lastSeen; });
        },
        onUserOnline: () { if (mounted) setState(() => _otherOnline = true); },
        onUserOffline: (lastSeen) {
          if (mounted) setState(() { _otherOnline = false; _otherLastSeen = lastSeen; });
        },
        onMessageReacted: (msgId, reactions) {
          if (mounted) {
            setState(() => _messages = MessageListOps.withReaction(_messages, msgId, reactions));
          }
        },
        onMessagesRead: (readBy) {
          if (mounted) {
            setState(() => _messages = MessageListOps.withRead(_messages, _myId ?? '', readBy));
          }
        },
        onMessageDeletedForAll: (msgId) {
          if (mounted) {
            setState(() => _messages = MessageListOps.withDeletedForAll(_messages, msgId));
          }
        },
      );
    listenForBlockedMessages(widget.match.matchId, _ctrl);
  }

  Future<void> _loadMessages() async {
    try {
      final msgs = await ChatService.getMessages(widget.match.matchId);
      final filtered = msgs.where((m) =>
          m.text.isNotEmpty || m.isImage || m.isAudio).toList();
      if (mounted) { setState(() { _messages = filtered; _loading = false; }); _scrollToBottom(); }
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
    rememberSentText(text);
    _ctrl.clear();
    _actions.sendText(text,
      replyTo: _replyingTo != null ? {
        'id': _replyingTo!.id, 'text': _replyingTo!.text, 'sender': _replyingTo!.sender,
        if (_replyingTo!.imageUrl != null) 'imageUrl': _replyingTo!.imageUrl,
      } : null,
    );
    if (mounted) setState(() => _replyingTo = null);
  }

  // A conversation starter the user confirmed: it goes out like a typed message.
  void _sendStarter(String text) {
    rememberSentText(text);
    _actions.sendStarter(text);
  }

  void _onTypingChanged() {
    final typing = _ctrl.text.isNotEmpty;
    if (typing == _wasTyping) return;
    _wasTyping = typing;
    typing
        ? SocketService.instance.emitTyping(widget.match.matchId)
        : SocketService.instance.emitStopTyping(widget.match.matchId);
  }

  void _showGenericError() {
    if (!mounted) return;
    showAppSnackBar(context, AppLocalizations.of(context)!.commonGenericError, backgroundColor: const Color(0xFF7F1D1D));
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      setState(() => _isRecording = false);
      final sent = await _actions.stopRecordingAndSend();
      if (mounted && !sent) _showGenericError();
    } else {
      final started = await _actions.startRecording();
      if (!started) { _showGenericError(); return; }
      if (mounted) setState(() => _isRecording = true);
    }
  }

  Future<void> _cancelRecording() async {
    await _actions.cancelRecording();
    if (mounted) setState(() => _isRecording = false);
  }

  Future<void> _pickAndSendImage() async {
    final result = await _actions.pickAndSendImage();
    if (result == false) _showGenericError();
  }

  Future<void> _deleteForMe(Message msg) async {
    await _actions.deleteForMe(msg.id);
    if (mounted) setState(() => _messages.removeWhere((m) => m.id == msg.id));
  }

  void _deleteForAll(Message msg) => _actions.deleteForAll(msg.id);

  @override
  void dispose() {
    _socketController.dispose();
    SocketService.instance.off('message_blocked');
    _actions.dispose();
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RequiresConnection(
        pageTitle: widget.match.username,
        child: ConversationScaffold(
          match:            widget.match,
          loading:          _loading,
          messages:         _messages,
          myId:             _myId,
          otherOnline:      _otherOnline,
          otherTyping:      _otherTyping,
          otherLastSeen:    _otherLastSeen,
          replyingTo:       _replyingTo,
          isRecording:      _isRecording,
          scrollController: _scroll,
          textController:   _ctrl,
          onSendStarter:    _sendStarter,
          onSwipeReply:     (m) => setState(() => _replyingTo = m),
          onReact:          (messageId, emoji) => SocketService.instance
              .reactMessage(widget.match.matchId, messageId, emoji),
          onDeleteForMe:    _deleteForMe,
          onDeleteForAll:   _deleteForAll,
          onCancelReply:    () => setState(() => _replyingTo = null),
          onSend:           _send,
          onImagePick:      _pickAndSendImage,
          onMicPress:       _toggleRecording,
          onMicCancel:      _cancelRecording,
          onTextChanged:    (_) => _onTypingChanged(),
        ),
      );
}

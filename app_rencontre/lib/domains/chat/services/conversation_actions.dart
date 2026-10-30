import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:nocturne/domains/chat/services/chat_service.dart';
import 'package:nocturne/shared/services/socket_service.dart';

/// Every outgoing action a conversation screen can take (send text, send a
/// conversation-starter, record/cancel/send audio, pick/send an image,
/// delete a message) — isolates ChatService/SocketService/ImagePicker/
/// AudioRecorder usage so the page itself only decides what to show, not how
/// to talk to any of them.
class ConversationActions {
  final String matchId;
  final AudioRecorder _recorder = AudioRecorder();

  ConversationActions({required this.matchId});

  void sendText(String text, {Map<String, dynamic>? replyTo}) {
    SocketService.instance.emitStopTyping(matchId);
    SocketService.instance.sendMessage(matchId, text, replyTo: replyTo);
  }

  void sendStarter(String text) => SocketService.instance.sendMessage(matchId, text);

  /// True if recording actually started (false on a denied permission).
  Future<bool> startRecording() async {
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) return false;
    final dir  = await getTemporaryDirectory();
    final path = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);
    return true;
  }

  /// True if the recording was uploaded and sent successfully.
  Future<bool> stopRecordingAndSend() async {
    final path = await _recorder.stop();
    if (path == null) return false;
    final url = await ChatService.uploadChatAudio(path);
    if (url == null) return false;
    SocketService.instance.sendMessage(matchId, '', audioUrl: url);
    return true;
  }

  Future<void> cancelRecording() => _recorder.stop();

  /// Null if the user just cancelled the picker (not an error). False if the
  /// upload failed. True on success.
  Future<bool?> pickAndSendImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null) return null;
    final url = await ChatService.uploadChatImage(img.path);
    if (url == null) return false;
    SocketService.instance.sendMessage(matchId, '', imageUrl: url);
    return true;
  }

  Future<void> deleteForMe(String messageId) => ChatService.deleteForMe(messageId);

  void deleteForAll(String messageId) =>
      SocketService.instance.emitDeleteForAll(matchId, messageId);

  void dispose() => _recorder.dispose();
}

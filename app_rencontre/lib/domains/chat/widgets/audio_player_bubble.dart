import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerBubble extends StatefulWidget {
  final String audioUrl;
  final bool   isMe;

  const AudioPlayerBubble({
    super.key,
    required this.audioUrl,
    required this.isMe,
  });

  @override
  State<AudioPlayerBubble> createState() => _AudioPlayerBubbleState();
}

class _AudioPlayerBubbleState extends State<AudioPlayerBubble> {
  final _player   = AudioPlayer();
  bool  _playing  = false;
  Duration _pos   = Duration.zero;
  Duration _dur   = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _playing = state == PlayerState.playing);
    });
    _player.onPositionChanged.listen((pos) {
      if (mounted) setState(() => _pos = pos);
    });
    _player.onDurationChanged.listen((dur) {
      if (mounted) setState(() => _dur = dur);
    });
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() { _playing = false; _pos = Duration.zero; });
    });
    _player.setSourceUrl(widget.audioUrl);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_playing) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.isMe
        ? Colors.white.withValues(alpha: 0.8)
        : const Color(0xFF7B00D4);
    final progress = _dur.inMilliseconds > 0
        ? _pos.inMilliseconds / _dur.inMilliseconds
        : 0.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _playing ? Icons.pause : Icons.play_arrow,
              color: accent, size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                value: progress.toDouble(),
                backgroundColor: accent.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(accent),
                minHeight: 3,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${_fmt(_pos)} / ${_fmt(_dur)}',
              style: TextStyle(color: accent, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Icon(Icons.graphic_eq, color: accent, size: 16),
      ],
    );
  }
}

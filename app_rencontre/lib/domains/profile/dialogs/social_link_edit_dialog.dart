import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/services/social_link_detector.dart';

/// Dialog to add, edit or remove one platform's link. Returns null when
/// cancelled, an empty string to mean "remove this link", or the new link
/// otherwise, already confirmed to match [platform] (its domain, not
/// whatever the user typed as a label).
Future<String?> showSocialLinkEditDialog(
  BuildContext context, {
  required String platform,
  required String? existingValue,
}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _SocialLinkEditDialog(platform: platform, existingValue: existingValue),
  );
}

class _SocialLinkEditDialog extends StatefulWidget {
  final String platform;
  final String? existingValue;

  const _SocialLinkEditDialog({required this.platform, required this.existingValue});

  @override
  State<_SocialLinkEditDialog> createState() => _SocialLinkEditDialogState();
}

class _SocialLinkEditDialogState extends State<_SocialLinkEditDialog> {
  late final _controller = TextEditingController(text: widget.existingValue ?? '');
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      Navigator.pop(context, '');
      return;
    }
    if (detectSocialPlatform(value) != widget.platform) {
      setState(() => _error = AppLocalizations.of(context)!.profileLinkWrongPlatform(widget.platform));
      return;
    }
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: const Color(0xFF1A0A1F),
      title: Text(widget.platform, style: const TextStyle(color: Colors.white)),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.url,
        style: const TextStyle(color: Colors.white),
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
        decoration: InputDecoration(
          hintText: l.profileHintSocialLink,
          hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
          errorText: _error,
          errorMaxLines: 2,
        ),
      ),
      actions: [
        if (widget.existingValue != null)
          TextButton(onPressed: () => Navigator.pop(context, ''), child: Text(l.commonBtnRemove)),
        TextButton(onPressed: () => Navigator.pop(context, null), child: Text(l.commonBtnCancel)),
        TextButton(onPressed: _save, child: Text(l.profileBtnSave)),
      ],
    );
  }
}

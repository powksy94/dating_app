import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class StepCoverInfo extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;
  const StepCoverInfo({super.key, required this.onNext});

  @override
  State<StepCoverInfo> createState() => _StepCoverInfoState();
}

class _StepCoverInfoState extends State<StepCoverInfo> {
  final _titleCtrl = TextEditingController();
  final _descCtrl  = TextEditingController();
  String? _coverPath;
  String? _error;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickCover() async {
    final img = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (img != null) setState(() => _coverPath = img.path);
  }

  void _next() {
    final title = _titleCtrl.text.trim();
    final desc  = _descCtrl.text.trim();
    if (title.isEmpty || desc.isEmpty) {
      setState(() => _error = AppLocalizations.of(context)!.eventErrorTitleDescRequired);
      return;
    }
    widget.onNext({
      'title':       title,
      'description': desc,
      'coverPath':   _coverPath,
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.eventStepCoverTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(l.eventStepCoverSubtitle,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _pickCover,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFF1A0A1F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF3D2A4A)),
                image: _coverPath != null
                    ? DecorationImage(
                        image: FileImage(File(_coverPath!)),
                        fit: BoxFit.cover)
                    : null,
              ),
              child: _coverPath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_photo_alternate_outlined,
                            size: 36, color: Color(0xFF5A4A6A)),
                        const SizedBox(height: 8),
                        Text(l.eventBtnAddCoverPhoto,
                            style: const TextStyle(
                                color: Color(0xFF5A4A6A), fontSize: 13)),
                      ],
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          _field(_titleCtrl, l.eventLabelTitleRequired),
          const SizedBox(height: 12),
          _field(_descCtrl, l.eventLabelDescriptionRequired, maxLines: 4),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!,
                style: const TextStyle(
                    color: Color(0xFFD400FF), fontSize: 12)),
          ],
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l.eventBtnContinue,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0D0010),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF7B00D4))),
      ),
    );
  }
}

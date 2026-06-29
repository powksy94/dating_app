import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/profile/services/photo_service.dart';

class EditStepPhotos extends StatefulWidget {
  final AlternativeProfile profile;
  const EditStepPhotos({super.key, required this.profile});

  @override
  State<EditStepPhotos> createState() => _EditStepPhotosState();
}

class _EditStepPhotosState extends State<EditStepPhotos> {
  late List<String> _existingPhotos;
  final List<String> _newPaths = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _existingPhotos = List.from(widget.profile.photos);
  }

  Future<void> _pickPhoto() async {
    if (_existingPhotos.length + _newPaths.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.profileSnackMaxPhotos)),
      );
      return;
    }
    final img = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (img != null) setState(() => _newPaths.add(img.path));
  }

  void _removeExisting(int i) =>
      setState(() => _existingPhotos.removeAt(i));

  void _removeNew(int i) => setState(() => _newPaths.removeAt(i));

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      List<String> uploadedUrls = [];
      if (_newPaths.isNotEmpty) {
        uploadedUrls = await PhotoService.uploadPhotos(_newPaths);
      }
      final allPhotos = [..._existingPhotos, ...uploadedUrls];
      await FirestoreService().saveProfile({'photos': allPhotos});

      if (mounted) {
        setState(() {
          _existingPhotos = allPhotos;
          _newPaths.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.profileSnackPhotosUpdated),
            backgroundColor: const Color(0xFF7B00D4),
          ),
        );
      }
    } catch (_) {} finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final total = _existingPhotos.length + _newPaths.length;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).padding.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.profileSectionPhotos,
              style: const TextStyle(
                  color: Color(0xFF7B00D4),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          const SizedBox(height: 4),
          Text(l.profilePhotoCount(total),
              style: const TextStyle(
                  color: Color(0xFF5A4A6A), fontSize: 12)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: total + (total < 6 ? 1 : 0),
            itemBuilder: (_, i) {
              if (i < _existingPhotos.length) {
                return _existingTile(_existingPhotos[i], i);
              }
              final newIdx = i - _existingPhotos.length;
              if (newIdx < _newPaths.length) {
                return _newTile(_newPaths[newIdx], newIdx);
              }
              return _addTile();
            },
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: _saving
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                  : Text(l.profileBtnSave,
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

  Widget _existingTile(String url, int i) => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(url, fit: BoxFit.cover),
        Positioned(
          top: 4, right: 4,
          child: GestureDetector(
            onTap: () => _removeExisting(i),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black54, shape: BoxShape.circle),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close,
                  size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _newTile(String path, int i) => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.file(File(path), fit: BoxFit.cover),
        Positioned(
          top: 4, right: 4,
          child: GestureDetector(
            onTap: () => _removeNew(i),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black54, shape: BoxShape.circle),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close,
                  size: 14, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 4, left: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF7B00D4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(AppLocalizations.of(context)!.profileBadgeNew,
                style: const TextStyle(
                    color: Colors.white, fontSize: 9)),
          ),
        ),
      ],
    ),
  );

  Widget _addTile() => GestureDetector(
    onTap: _pickPhoto,
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A1F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color(0xFF3D2A4A), style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_photo_alternate_outlined,
              size: 28, color: Color(0xFF5A4A6A)),
          const SizedBox(height: 4),
          Text(AppLocalizations.of(context)!.profileBtnAddPhoto,
              style: const TextStyle(
                  color: Color(0xFF5A4A6A), fontSize: 11)),
        ],
      ),
    ),
  );
}

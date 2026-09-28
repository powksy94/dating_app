import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/services/firestore_service.dart';
import 'package:nocturne/domains/profile/services/photo_service.dart';
import 'package:nocturne/domains/profile/widgets/photo_tile_existing.dart';
import 'package:nocturne/domains/profile/widgets/photo_tile_pending.dart';
import 'package:nocturne/domains/profile/widgets/photo_tile_new.dart';
import 'package:nocturne/domains/profile/widgets/photo_tile_add.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

class EditStepPhotos extends StatefulWidget {
  final AlternativeProfile profile;
  const EditStepPhotos({super.key, required this.profile});

  @override
  State<EditStepPhotos> createState() => _EditStepPhotosState();
}

class _EditStepPhotosState extends State<EditStepPhotos> {
  late List<String> _existingPhotos;
  final List<String> _newPaths = [];
  List<String> _pendingPhotos = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _existingPhotos = List.from(widget.profile.photos);
    _loadPending();
  }

  Future<void> _loadPending() async {
    final pending = await PhotoService.getPending();
    if (mounted) setState(() => _pendingPhotos = pending);
  }

  Future<void> _pickPhoto() async {
    if (_existingPhotos.length + _pendingPhotos.length + _newPaths.length >= 6) {
      showAppSnackBar(context, AppLocalizations.of(context)!.profileSnackMaxPhotos, backgroundColor: const Color(0xFF7F1D1D));
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
      var approvedFromUpload = <String>[];
      var pendingCount = 0;
      var rejectedCount = 0;
      if (_newPaths.isNotEmpty) {
        final result = await PhotoService.uploadPhotos(_newPaths);
        approvedFromUpload = result.approved;
        pendingCount       = result.pendingCount;
        rejectedCount      = result.rejectedCount;
      }
      // Only already-approved photos ever reach this call: a photo still
      // waiting for moderation isn't part of Profile.photos yet (see
      // uploadPhotos on the backend), so it has nothing to merge in here.
      final allPhotos = [..._existingPhotos, ...approvedFromUpload];
      await FirestoreService().saveProfile({'photos': allPhotos});
      if (pendingCount > 0) await _loadPending();

      if (mounted) {
        setState(() {
          _existingPhotos = allPhotos;
          _newPaths.clear();
        });
        final l = AppLocalizations.of(context)!;
        if (pendingCount > 0 || rejectedCount > 0) {
          final parts = [
            if (pendingCount > 0) l.profileSnackPhotosPending(pendingCount),
            if (rejectedCount > 0) l.profileSnackPhotosAutoRejected(rejectedCount),
          ];
          showAppSnackBar(context, parts.join('. '), backgroundColor: const Color(0xFF7B00D4));
        } else {
          showAppSnackBar(context, l.profileSnackPhotosUpdated, backgroundColor: const Color(0xFF7B00D4));
        }
      }
    } catch (_) {} finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final total = _existingPhotos.length + _pendingPhotos.length + _newPaths.length;
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
                return PhotoTileExisting(
                  url: _existingPhotos[i],
                  onRemove: () => _removeExisting(i),
                );
              }
              final pendingIdx = i - _existingPhotos.length;
              if (pendingIdx < _pendingPhotos.length) {
                return PhotoTilePending(url: _pendingPhotos[pendingIdx]);
              }
              final newIdx = pendingIdx - _pendingPhotos.length;
              if (newIdx < _newPaths.length) {
                return PhotoTileNew(
                  path: _newPaths[newIdx],
                  onRemove: () => _removeNew(newIdx),
                );
              }
              return PhotoTileAdd(onTap: _pickPhoto);
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
}

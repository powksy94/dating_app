import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_photo_review_service.dart';
import 'package:nocturne/domains/admin/services/photo_review_actions.dart';
import 'package:nocturne/domains/admin/widgets/photo_review_card.dart';

class PhotoReviewPage extends StatefulWidget {
  const PhotoReviewPage({super.key});

  @override
  State<PhotoReviewPage> createState() => _PhotoReviewPageState();
}

class _PhotoReviewPageState extends State<PhotoReviewPage> {
  List<Map<String, dynamic>> _photos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final photos = await AdminPhotoReviewService.getPending();
    if (mounted) setState(() { _photos = photos; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final actions = PhotoReviewActions(
      context: context,
      onDecided: (photoId) => setState(() => _photos.removeWhere((p) => p['_id'] == photoId)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0010),
        elevation: 0,
        title: Text(l.photoReviewTitle,
            style: const TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7B00D4)))
          : _photos.isEmpty
              ? Center(
                  child: Text(l.photoReviewEmpty,
                      style: const TextStyle(color: Color(0xFFAA9AB5))))
              : RefreshIndicator(
                  onRefresh: _load,
                  color: const Color(0xFF7B00D4),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: _photos.length,
                    itemBuilder: (_, i) => PhotoReviewCard(
                      photo: _photos[i],
                      onApprove: () => actions.approve(_photos[i]['_id'] as String),
                      onReject: () => actions.reject(_photos[i]['_id'] as String),
                    ),
                  ),
                ),
    );
  }
}

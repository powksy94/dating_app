import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_photo_review_service.dart';
import 'package:nocturne/domains/admin/views/photo_review_detail_page.dart';
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

  Future<void> _openDetail(Map<String, dynamic> photo) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => PhotoReviewDetailPage(photo: photo)),
    );
    if (result == null || !mounted) return;

    setState(() => _photos.removeWhere((p) => p['_id'] == photo['_id']));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

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
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _photos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => PhotoReviewCard(
                      photo: _photos[i],
                      onTap: () => _openDetail(_photos[i]),
                    ),
                  ),
                ),
    );
  }
}

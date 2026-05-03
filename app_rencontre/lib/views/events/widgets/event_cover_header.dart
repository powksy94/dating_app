import 'package:flutter/material.dart';

class EventCoverHeader extends StatelessWidget {
  final String coverImageUrl;
  final double expandedHeight;

  const EventCoverHeader({
    super.key,
    required this.coverImageUrl,
    this.expandedHeight = 260,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: const Color(0xFF0D0010),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: coverImageUrl.isNotEmpty
            ? Image.network(coverImageUrl, fit: BoxFit.cover)
            : Container(
                color: const Color(0xFF2D0040),
                child: const Center(
                  child: Icon(Icons.music_note,
                      size: 64, color: Color(0xFF7B00D4)),
                ),
              ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// A freshly picked local photo, not uploaded yet, removable before saving.
class PhotoTileNew extends StatelessWidget {
  final String path;
  final VoidCallback onRemove;
  const PhotoTileNew({super.key, required this.path, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(path), fit: BoxFit.cover),
          Positioned(
            top: 4, right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black54, shape: BoxShape.circle),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 4, left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF7B00D4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(AppLocalizations.of(context)!.profileBadgeNew,
                  style: const TextStyle(color: Colors.white, fontSize: 9)),
            ),
          ),
        ],
      ),
    );
  }
}

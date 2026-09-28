import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// The trailing grid tile that lets the user pick another photo.
class PhotoTileAdd extends StatelessWidget {
  final VoidCallback onTap;
  const PhotoTileAdd({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF3D2A4A), style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_photo_alternate_outlined, size: 28, color: Color(0xFF5A4A6A)),
            const SizedBox(height: 4),
            Text(AppLocalizations.of(context)!.profileBtnAddPhoto,
                style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

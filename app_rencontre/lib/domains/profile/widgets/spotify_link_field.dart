import 'package:flutter/material.dart';

/// Plain text input for a Spotify profile link, styled like the rest of the
/// dark profile forms. The server only keeps the value if it actually points
/// to a Spotify domain (see profile-validation.ts, validateSocialLinks);
/// anything else is silently dropped on save, so no client-side validation
/// is enforced here beyond letting the user type a URL.
class SpotifyLinkField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const SpotifyLinkField({super.key, required this.controller, required this.hint});

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.url,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
        filled: true,
        fillColor: const Color(0xFF1A0A1F),
        border: _border(const Color(0xFF3D2A4A)),
        enabledBorder: _border(const Color(0xFF3D2A4A)),
        focusedBorder: _border(const Color(0xFF7B00D4)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }
}

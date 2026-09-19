import 'package:flutter/material.dart';

/// Text input of the favorite bands field, with the shared dark styling.
class BandTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;

  const BandTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.errorText,
    required this.maxLength,
    required this.onChanged,
    required this.onSubmitted,
  });

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
        errorText: errorText,
        counterText: '',
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

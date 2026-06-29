import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ProfileBioField extends StatelessWidget {
  final TextEditingController controller;
  const ProfileBioField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, val, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: controller,
            maxLines: 4,
            maxLength: 700,
            buildCounter: (_, {required currentLength,
                required isFocused, maxLength}) => null,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: l.profileHintBio,
              hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
              filled: true,
              fillColor: const Color(0xFF1A0A1F),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF7B00D4))),
            ),
          ),
          const SizedBox(height: 4),
          Text('${val.text.length}/700',
              style: const TextStyle(
                  color: Color(0xFF5A4A6A), fontSize: 11)),
        ],
      ),
    );
  }
}

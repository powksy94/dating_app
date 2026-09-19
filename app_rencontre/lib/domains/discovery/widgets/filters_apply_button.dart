import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class FiltersApplyButton extends StatelessWidget {
  final bool saving;
  final VoidCallback onPressed;
  const FiltersApplyButton({super.key, required this.saving, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton(
          onPressed: saving ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7B00D4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: saving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  AppLocalizations.of(context)!.discoveryFiltersApply,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class EventAttendButton extends StatelessWidget {
  final bool isAttending;
  final bool loading;
  final VoidCallback? onPressed;

  const EventAttendButton({
    super.key,
    required this.isAttending,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isAttending
              ? const Color(0xFF2D0040)
              : const Color(0xFF7B00D4),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isAttending ? const Color(0xFF7B00D4) : Colors.transparent,
            ),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 14, height: 14,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : Text(
                isAttending
                    ? AppLocalizations.of(context)!.eventBadgeRegistered
                    : AppLocalizations.of(context)!.eventBtnRegister,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/event/models/event_model.dart';
import 'package:nocturne/shared/utils/date_formatting.dart';
import 'package:nocturne/shared/widgets/common/app_snackbar.dart';

class RegisterSheet extends StatefulWidget {
  final EventModel event;
  final Future<bool> Function() onConfirm;

  const RegisterSheet({
    super.key,
    required this.event,
    required this.onConfirm,
  });

  @override
  State<RegisterSheet> createState() => _RegisterSheetState();
}

class _RegisterSheetState extends State<RegisterSheet> {
  bool _loading = false;

  Future<void> _confirm() async {
    setState(() => _loading = true);
    final success = await widget.onConfirm();
    if (!mounted) return;
    if (!success) {
      setState(() => _loading = false);
      showAppSnackBar(context, AppLocalizations.of(context)!.commonGenericError, backgroundColor: const Color(0xFF7F1D1D));
    }
    // On success, onConfirm already closes the sheet itself.
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, 24 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF3D2A4A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            event.isAttending
                ? AppLocalizations.of(context)!.eventSheetUnregisterTitle
                : AppLocalizations.of(context)!.eventSheetRegisterTitle,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _row(Icons.music_note_outlined,         event.title),
          const SizedBox(height: 8),
          _row(Icons.calendar_today_outlined,     formatEventDate(context, event.date)),
          const SizedBox(height: 8),
          _row(Icons.location_on_outlined,        event.city),
          const SizedBox(height: 8),
          _row(
            Icons.confirmation_number_outlined,
            event.isFree
                ? AppLocalizations.of(context)!.eventPriceFree
                : '${event.price?.toStringAsFixed(0)} €',
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _loading ? null : _confirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: event.isAttending
                    ? const Color(0xFF8B0000)
                    : const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: _loading
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(
                      event.isAttending
                          ? AppLocalizations.of(context)!.eventBtnConfirmUnregister
                          : AppLocalizations.of(context)!.eventBtnConfirmRegister,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _loading ? null : () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.eventBtnCancel,
                  style: const TextStyle(color: Color(0xFF5A4A6A))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF5A4A6A)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                  color: Color(0xFFAA9AB5), fontSize: 13)),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/elegie/widgets/elegie_quota_pill.dart';
import 'package:nocturne/domains/elegie/widgets/elegie_paywall_banner.dart';

class ElegieSheetBody extends StatelessWidget {
  final AlternativeProfile profile;
  final TextEditingController ctrl;
  final bool sending;
  final bool statusLoading;
  final bool unlimited;
  final int remaining;
  final int limit;
  final VoidCallback onSend;
  final VoidCallback onPaywall;

  const ElegieSheetBody({
    super.key,
    required this.profile,
    required this.ctrl,
    required this.sending,
    required this.statusLoading,
    required this.unlimited,
    required this.remaining,
    required this.limit,
    required this.onSend,
    required this.onPaywall,
  });

  bool get _limitReached => !unlimited && remaining <= 0;

  @override
  Widget build(BuildContext context) {
    final kb = MediaQuery.of(context).viewInsets.bottom;
    final sb = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, kb + sb + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4,
            decoration: BoxDecoration(color: const Color(0xFF3D2A4A), borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          Row(children: [
            const Icon(Icons.edit_note, color: Color(0xFF7B00D4), size: 22),
            const SizedBox(width: 8),
            Expanded(child: Text(AppLocalizations.of(context)!.elegieSheetTitle(profile.username),
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
            if (!statusLoading && !unlimited)
              ElegieQuotaPill(remaining: remaining, limit: limit),
          ]),
          const SizedBox(height: 6),
          Text(AppLocalizations.of(context)!.elegieSheetSubtitle,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
          const SizedBox(height: 16),
          if (_limitReached)
            ElegiePaywallBanner(onPaywall: onPaywall)
          else ...[
            _TextField(ctrl: ctrl),
            const SizedBox(height: 16),
            _SendButton(sending: sending, onSend: onSend),
          ],
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController ctrl;
  const _TextField({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ctrl,
      builder: (_, value, __) {
        final count = value.text.length;
        return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            controller: ctrl, maxLength: 200, maxLines: 4, autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.elegieHintMessage, hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
              filled: true, fillColor: const Color(0xFF0D0010), counterText: '',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF7B00D4))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
            ),
          ),
          const SizedBox(height: 4),
          Text('$count / 200', style: TextStyle(
            color: count > 180 ? const Color(0xFFD400FF) : const Color(0xFF5A4A6A), fontSize: 11)),
        ]);
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool sending;
  final VoidCallback onSend;
  const _SendButton({required this.sending, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        onPressed: sending ? null : onSend,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7B00D4),
          disabledBackgroundColor: const Color(0xFF3D2A4A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: sending
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(AppLocalizations.of(context)!.elegieBtnSend, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/domains/match/models/chat_match.dart';
import 'package:nocturne/domains/elegie/services/elegie_service.dart';
import 'package:nocturne/domains/elegie/widgets/elegie_sheet_body.dart';
import 'package:nocturne/domains/match/widgets/match_overlay.dart';
import 'package:nocturne/domains/subscription/widgets/paywall_sheet.dart';

void showElegieBottomSheet(
  BuildContext context,
  AlternativeProfile profile,
  void Function(ChatMatch)? onNavigateToConversation,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1A0A1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => _ElegieSheet(
      profile: profile,
      pageContext: context,
      onNavigateToConversation: onNavigateToConversation,
    ),
  );
}

class _ElegieSheet extends StatefulWidget {
  final AlternativeProfile profile;
  final BuildContext pageContext;
  final void Function(ChatMatch)? onNavigateToConversation;
  const _ElegieSheet({required this.profile, required this.pageContext, this.onNavigateToConversation});

  @override
  State<_ElegieSheet> createState() => _ElegieSheetState();
}

class _ElegieSheetState extends State<_ElegieSheet> {
  final _ctrl = TextEditingController();
  bool _sending       = false;
  bool _unlimited     = true;
  int  _remaining     = 0;
  int  _limit         = 3;
  bool _statusLoading = true;

  @override
  void initState() { super.initState(); _loadStatus(); }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Future<void> _loadStatus() async {
    final s = await ElegieService.getStatus();
    if (!mounted) return;
    setState(() {
      _unlimited     = s['unlimited'] as bool? ?? true;
      _remaining     = s['remaining'] as int?  ?? 0;
      _limit         = s['limit']     as int?  ?? 3;
      _statusLoading = false;
    });
  }

  Future<void> _send() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    final pageCtx = widget.pageContext;
    try {
      final matchId = await ElegieService.sendElegie(widget.profile.uid, text);
      if (!mounted) return;
      if (!_unlimited) setState(() => _remaining = (_remaining - 1).clamp(0, _limit));
      Navigator.pop(context);
      if (!pageCtx.mounted) return;
      if (matchId != null) {
        final chatMatch = ChatMatch(
          matchId: matchId, userId: widget.profile.uid,
          username: widget.profile.username, avatarUrl: widget.profile.avatarUrl,
        );
        Navigator.push(pageCtx, PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => MatchOverlay(
            matchedProfile: widget.profile, myAvatarUrl: null,
            isElegieMatch: true, elegieText: text,
            onMessage: () => widget.onNavigateToConversation?.call(chatMatch),
          ),
        ));
      } else {
        ScaffoldMessenger.of(pageCtx).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(pageCtx)!.elegieSnackSent(widget.profile.username)),
          backgroundColor: const Color(0xFF4A0072),
        ));
      }
    } catch (_) {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _showPaywall() => PaywallSheet.show(
    context,
    title: AppLocalizations.of(context)!.elegieLimitReachedTitle,
    description: AppLocalizations.of(context)!.elegieLimitReachedBody(_limit),
    requiredPlan: 'nocturne',
    icon: Icons.edit_note,
  );

  @override
  Widget build(BuildContext context) => ElegieSheetBody(
    profile:       widget.profile,
    ctrl:          _ctrl,
    sending:       _sending,
    statusLoading: _statusLoading,
    unlimited:     _unlimited,
    remaining:     _remaining,
    limit:         _limit,
    onSend:        _send,
    onPaywall:     _showPaywall,
  );
}

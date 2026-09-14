import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/elegie/models/elegie.dart';
import 'package:nocturne/domains/elegie/services/elegie_service.dart';
import 'package:nocturne/domains/chat/widgets/chat_empty_state.dart';
import 'package:nocturne/domains/chat/widgets/elegie_tile.dart';

class ElegiesSentTab extends StatefulWidget {
  const ElegiesSentTab({super.key});
  @override
  State<ElegiesSentTab> createState() => _ElegiesSentTabState();
}

class _ElegiesSentTabState extends State<ElegiesSentTab> {
  List<Elegie> _elegies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final list = await ElegieService.getSent();
      if (mounted) setState(() { _elegies = list; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_elegies.isEmpty) {
      return ChatEmptyState(
        icon: Icons.send_outlined,
        message: AppLocalizations.of(context)!.chatEmptyElegiesSentTitle,
        sub: AppLocalizations.of(context)!.chatEmptyElegiesSentSub,
      );
    }
    return ListView.separated(
      itemCount: _elegies.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Color(0xFF1A0A1F), height: 1),
      itemBuilder: (_, i) => ElegieTile(elegie: _elegies[i]),
    );
  }
}

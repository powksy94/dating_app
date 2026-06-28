import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/discovery/services/swipe_service.dart';
import 'package:nocturne/domains/discovery/models/liked_profile.dart';
import 'package:nocturne/domains/discovery/widgets/like_profile_card.dart';
import 'package:nocturne/domains/subscription/widgets/paywall_sheet.dart';

class WhoLikedMeTab extends StatefulWidget {
  const WhoLikedMeTab({super.key});

  @override
  State<WhoLikedMeTab> createState() => _WhoLikedMeTabState();
}

class _WhoLikedMeTabState extends State<WhoLikedMeTab> with AutomaticKeepAliveClientMixin {
  List<LikedProfile> _profiles = [];
  bool _loading   = true;
  bool _forbidden = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final result = await SwipeService.getWhoLikedMe();
    if (!mounted) return;
    if (result.forbidden) {
      setState(() { _forbidden = true; _loading = false; });
      return;
    }
    final profiles = result.profiles.map((m) => LikedProfile(
      uid:      m['uid']?.toString()  ?? '',
      username: m['username'] as String? ?? '',
      avatarUrl: m['avatarUrl'] as String? ?? '',
      photos:   List<String>.from(m['photos'] ?? []),
      age:      m['age'] as int?,
      isMatch:  false,
    )).toList();
    setState(() { _profiles = profiles; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_forbidden) return _PaywallState();

    if (_profiles.isEmpty) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.visibility_off, size: 48, color: Color(0xFF7B00D4)),
          const SizedBox(height: 12),
          Text(AppLocalizations.of(context)!.discoveryEmptyWhoLikedMe, style: const TextStyle(color: Color(0xFFAA9AB5))),
        ]),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.72,
      ),
      itemCount: _profiles.length,
      itemBuilder: (_, i) => LikeProfileCard(profile: _profiles[i]),
    );
  }
}

class _PaywallState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, size: 56, color: Color(0xFF7B00D4)),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.discoveryPaywallTitle,
              style: const TextStyle(color: Color(0xFFE8E0EE), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.discoveryPaywallDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => PaywallSheet.show(
                context,
                title: AppLocalizations.of(context)!.discoveryPaywallSheetTitle,
                description: AppLocalizations.of(context)!.discoveryPaywallSheetDescription,
                requiredPlan: 'nocturne',
                icon: Icons.favorite,
              ),
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: Text(AppLocalizations.of(context)!.discoveryBtnUpgrade),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A0072),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF7B00D4)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

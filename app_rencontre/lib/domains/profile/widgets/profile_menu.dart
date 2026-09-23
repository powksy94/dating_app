import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/profile/dialogs/discord_connection_dialog.dart';
import 'package:nocturne/domains/profile/dialogs/social_link_edit_dialog.dart';
import 'package:nocturne/domains/profile/services/discord_oauth_service.dart';
import 'package:nocturne/domains/profile/widgets/profile_menu_item.dart';
import 'package:nocturne/domains/profile/widgets/social_link_chip.dart';
import 'package:nocturne/shared/services/firestore_service.dart';

// Every platform this app has icons and validation for (see social-links.ts on
// the server, which must stay in sync with this list). Discord isn't part of
// _links: it's a real connection (see DiscordOAuthService), not a pasted link.
const _kPlatforms = ['spotify', 'instagram', 'bandcamp', 'discord', 'lastfm', 'tumblr'];

/// Profile menu bottom sheet: navigation to the like history, visitors, matches
/// and settings screens, plus the profile's external links as tappable
/// pastilles (editing itself lives in social_link_edit_dialog.dart and
/// discord_connection_dialog.dart, this widget only wires them to a save).
class ProfileMenu extends StatefulWidget {
  final Map<String, String> socialLinks;
  final VoidCallback onLinksChanged;

  const ProfileMenu({
    super.key,
    required this.socialLinks,
    required this.onLinksChanged,
  });

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  late Map<String, String> _links = Map.from(widget.socialLinks);
  DiscordConnectionStatus _discord = const DiscordConnectionStatus(connected: false);
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    DiscordOAuthService.status().then((status) {
      if (mounted) setState(() => _discord = status);
    });
  }

  Future<void> _apply(Map<String, String> updated) async {
    final previous = _links;
    setState(() { _links = updated; _saving = true; });
    try {
      await FirestoreService().saveProfile({'socialLinks': updated});
      widget.onLinksChanged();
    } catch (_) {
      if (mounted) {
        setState(() => _links = previous);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.commonGenericError),
          backgroundColor: const Color(0xFF7F1D1D),
        ));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _onDiscordTap() async {
    final action = await showDiscordConnectionDialog(
      context,
      connected: _discord.connected,
      username: _discord.username,
    );
    if (!mounted || action == null) return;

    setState(() => _saving = true);
    try {
      if (action == 'disconnect') {
        await DiscordOAuthService.disconnect();
        if (mounted) setState(() => _discord = const DiscordConnectionStatus(connected: false));
      } else {
        final status = await DiscordOAuthService.connect();
        if (mounted) setState(() => _discord = status);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.profileDiscordConnectFailed),
          backgroundColor: const Color(0xFF7F1D1D),
        ));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _onChipTap(String platform) async {
    if (platform == 'discord') {
      await _onDiscordTap();
      return;
    }
    final result = await showSocialLinkEditDialog(
      context,
      platform: platform,
      existingValue: _links[platform],
    );
    if (!mounted || result == null) return;
    await _apply(result.isEmpty ? ({..._links}..remove(platform)) : {..._links, platform: result});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      decoration: const BoxDecoration(
        color: Color(0xFF120018),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF3D2A4A),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    l.profileMenuTitle,
                    style: const TextStyle(
                      color: Color(0xFF7B00D4),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileMenuItem(
                    icon: Icons.favorite_border,
                    label: l.profileMenuLikesHistory,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/likes-history');
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.remove_red_eye_outlined,
                    label: l.profileMenuVisitors,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/visitors');
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.people_outline,
                    label: l.profileMenuMatches,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/matches');
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    label: l.profileMenuSettings,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l.profileSectionSocialLinksCaps,
                        style: const TextStyle(
                          color: Color(0xFF7B00D4),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final platform in _kPlatforms)
                          SocialLinkChip(
                            platform: platform,
                            isSet: platform == 'discord' ? _discord.connected : _links.containsKey(platform),
                            enabled: !_saving,
                            onTap: () => _onChipTap(platform),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

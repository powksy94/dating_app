import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_status_service.dart';
import 'package:nocturne/domains/settings/widgets/settings_titles.dart';

/// Only visible to the mobile account linked to an Admin — gives quick
/// access to report moderation without waiting for the push notification.
class AdminSection extends StatefulWidget {
  const AdminSection({super.key});

  @override
  State<AdminSection> createState() => _AdminSectionState();
}

class _AdminSectionState extends State<AdminSection> {
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final isAdmin = await AdminStatusService.isLinkedAdmin();
    if (mounted) setState(() => _isAdmin = isAdmin);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdmin) return const SizedBox.shrink();

    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l.settingsSectionAdmin),
        ActionTile(
          icon: Icons.shield_outlined,
          label: l.settingsAdminReports,
          onTap: () => Navigator.pushNamed(context, '/report-review'),
        ),
      ],
    );
  }
}

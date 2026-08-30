import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class SwipeEmptyState extends StatelessWidget {
  final VoidCallback onResetLikes;
  final VoidCallback onEditFilters;
  final VoidCallback onWaitForMoon;

  const SwipeEmptyState({
    super.key,
    required this.onResetLikes,
    required this.onEditFilters,
    required this.onWaitForMoon,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.nightlight, size: 64, color: Color(0xFF7B00D4)),
          const SizedBox(height: 16),
          Text(
            l.discoveryEmptyProfiles,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            l.discoveryEmptySubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
          ),
          const SizedBox(height: 28),
          _EmptyStateOption(
            icon: Icons.replay,
            label: l.discoveryEmptyResetLikes,
            onTap: onResetLikes,
          ),
          const SizedBox(height: 12),
          _EmptyStateOption(
            icon: Icons.tune,
            label: l.discoveryEmptyEditFilters,
            onTap: onEditFilters,
          ),
          const SizedBox(height: 12),
          _EmptyStateOption(
            icon: Icons.dark_mode_outlined,
            label: l.discoveryEmptyWaitMoon,
            onTap: onWaitForMoon,
          ),
        ]),
      ),
    );
  }
}

class _EmptyStateOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _EmptyStateOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: const Color(0xFF7B00D4)),
        label: Text(label, style: const TextStyle(color: Color(0xFFE8E0EE))),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFF3D2A4A)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

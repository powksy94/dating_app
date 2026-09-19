import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:nocturne/l10n/app_localizations.dart';

/// App logo and current version, shown at the very bottom of the settings.
class AppInfoFooter extends StatelessWidget {
  const AppInfoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 32, 16, 32 + MediaQuery.of(context).padding.bottom),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/icons/app_icon.png', width: 64, height: 64),
          ),
          const SizedBox(height: 10),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final info = snapshot.data;
              // Empty until loaded so the footer keeps its height.
              final text = info == null
                  ? ''
                  : '${l.settingsVersionLabel} ${info.version} (${info.buildNumber})';
              return Text(
                text,
                style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
              );
            },
          ),
        ],
      ),
    );
  }
}

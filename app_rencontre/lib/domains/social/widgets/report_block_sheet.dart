import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/social/services/user_action_service.dart';
import 'package:nocturne/domains/social/widgets/report_flow.dart';

void showReportBlockSheet(
  BuildContext context, {
  required String userId,
  required String username,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A0A1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
                color: const Color(0xFF3D2A4A),
                borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.flag_outlined,
                color: Color(0xFFAA9AB5)),
            title: Text(AppLocalizations.of(context)!.socialBtnReport,
                style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              showReportFlow(context, userId: userId, username: username);
            },
          ),
          ListTile(
            leading: const Icon(Icons.block, color: Color(0xFF8B0000)),
            title: Text(AppLocalizations.of(context)!.socialBtnBlock,
                style: const TextStyle(color: Color(0xFF8B0000))),
            onTap: () {
              Navigator.pop(context);
              showBlockDialog(context, userId: userId, username: username);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

void showBlockDialog(
  BuildContext context, {
  required String userId,
  required String username,
  VoidCallback? onBlocked,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xFF1A0A1F),
      title: Text(AppLocalizations.of(context)!.socialBtnBlock,
          style: const TextStyle(color: Colors.white)),
      content: Text(
        AppLocalizations.of(context)!.socialDialogBlockBody(username),
        style: const TextStyle(color: Color(0xFFAA9AB5)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.socialBtnCancel,
              style: const TextStyle(color: Color(0xFF5A4A6A))),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await UserActionService.blockUser(userId);
            if (onBlocked != null) {
              onBlocked();
            } else if (context.mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
          child: Text(AppLocalizations.of(context)!.socialBtnBlock,
              style: const TextStyle(
                  color: Color(0xFF8B0000),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

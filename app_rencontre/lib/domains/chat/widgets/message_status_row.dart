import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class MessageStatusRow extends StatelessWidget {
  final DateTime createdAt;
  final bool     isMe;
  final bool     showReadReceipt;
  final bool     isRead;
  final bool     deletedForAll;

  const MessageStatusRow({
    super.key,
    required this.createdAt,
    required this.isMe,
    required this.showReadReceipt,
    required this.isRead,
    required this.deletedForAll,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(DateFormat.jm(locale).format(createdAt),
            style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 10)),
        if (isMe && showReadReceipt && !deletedForAll) ...[
          const SizedBox(width: 4),
          Text(
            isRead
                ? AppLocalizations.of(context)!.chatStatusRead
                : AppLocalizations.of(context)!.chatStatusSent,
            style: TextStyle(
              color: isRead ? const Color(0xFF7B00D4) : const Color(0xFF5A4A6A),
              fontSize: 10,
            ),
          ),
        ],
      ],
    );
  }
}

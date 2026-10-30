import 'package:flutter/widgets.dart';
import 'package:nocturne/l10n/app_localizations.dart';

String formatLastSeenText(BuildContext context, DateTime? lastSeen) {
  if (lastSeen == null) return '';
  final l = AppLocalizations.of(context)!;
  final diff = DateTime.now().difference(lastSeen);
  if (diff.inMinutes < 1)  return l.chatLastSeenJustNow;
  if (diff.inMinutes < 60) return l.chatLastSeenMinutesAgo(diff.inMinutes);
  if (diff.inHours < 24)   return l.chatLastSeenHoursAgo(diff.inHours);
  return l.chatLastSeenDaysAgo(diff.inDays);
}

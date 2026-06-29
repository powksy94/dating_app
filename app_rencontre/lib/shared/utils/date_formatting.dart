import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nocturne/l10n/app_localizations.dart';

String formatEventDate(BuildContext context, DateTime d) {
  final locale = Localizations.localeOf(context).toString();
  final datePart = DateFormat('d MMMM yyyy', locale).format(d);
  final timePart = DateFormat.jm(locale).format(d);
  return AppLocalizations.of(context)!.eventDateAtTime(datePart, timePart);
}

String formatEventDateCompact(BuildContext context, DateTime d) {
  final locale = Localizations.localeOf(context).toString();
  final datePart = DateFormat.yMd(locale).format(d);
  final timePart = DateFormat.jm(locale).format(d);
  return '$datePart · $timePart';
}

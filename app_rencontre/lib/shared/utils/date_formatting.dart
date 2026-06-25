import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatEventDate(BuildContext context, DateTime d) {
  final locale = Localizations.localeOf(context).toString();
  final datePart = DateFormat('d MMMM yyyy', locale).format(d);
  final hour = d.hour.toString().padLeft(2, '0');
  final minute = d.minute.toString().padLeft(2, '0');
  return '$datePart à ${hour}h$minute';
}

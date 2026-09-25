import 'package:flutter/material.dart';

/// Shows a SnackBar with an explicit light text color. The theme's default
/// SnackBar text color assumes a light background and reads as near
/// invisible against this app's dark, hand-picked background colors
/// otherwise (found the hard way on the "wait for a new moon" message).
void showAppSnackBar(
  BuildContext context,
  String message, {
  required Color backgroundColor,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white)),
    backgroundColor: backgroundColor,
    duration: duration ?? const Duration(milliseconds: 4000),
  ));
}

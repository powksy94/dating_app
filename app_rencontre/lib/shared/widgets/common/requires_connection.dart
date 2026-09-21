import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/services/connectivity_service.dart';

/// Wraps a screen that cannot work without a connection (swipe, chats,
/// matches, subscription). While the device is offline the screen is hidden
/// and a "connection required" view is shown instead. The screen stays
/// mounted underneath, so a half-typed message or a scroll position survives
/// a short network drop, and focus is released so the keyboard closes.
class RequiresConnection extends StatelessWidget {
  final Widget child;
  final String pageTitle;
  final String? message;

  const RequiresConnection({
    super.key,
    required this.child,
    required this.pageTitle,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ConnectivityService.online,
      builder: (context, online, _) => Stack(
        fit: StackFit.expand,
        children: [
          ExcludeFocus(
            excluding: !online,
            child: Visibility(
              visible: online,
              maintainState: true,
              child: child,
            ),
          ),
          if (!online) _OfflineView(pageTitle: pageTitle, message: message),
        ],
      ),
    );
  }
}

class _OfflineView extends StatelessWidget {
  final String pageTitle;
  final String? message;

  const _OfflineView({required this.pageTitle, this.message});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          pageTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_outlined, size: 64, color: Color(0xFF7B00D4)),
              const SizedBox(height: 16),
              Text(
                l.commonConnectionRequiredTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                message ?? l.commonConnectionRequiredBody,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/admin/services/admin_lock_service.dart';

/// Wraps an admin screen so it only shows once AdminLockService confirms a
/// fingerprint check. Also re-checks on its own: if the app was backgrounded
/// while this screen was still on top (app.dart already called
/// AdminLockService.lock() at that point), coming back to the foreground
/// re-prompts immediately instead of leaving the screen visible underneath.
class AdminLockGate extends StatefulWidget {
  final Widget child;
  const AdminLockGate({super.key, required this.child});

  @override
  State<AdminLockGate> createState() => _AdminLockGateState();
}

class _AdminLockGateState extends State<AdminLockGate> with WidgetsBindingObserver {
  bool _checking = true;
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryUnlock());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !AdminLockService.unlocked && mounted) {
      setState(() { _checking = true; _unlocked = false; });
      _tryUnlock();
    }
  }

  Future<void> _tryUnlock() async {
    final reason = AppLocalizations.of(context)!.adminLockLocalizedReason;
    final ok = await AdminLockService.ensureUnlocked(reason);
    if (mounted) setState(() { _checking = false; _unlocked = ok; });
  }

  @override
  Widget build(BuildContext context) {
    if (_unlocked) return widget.child;

    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.fingerprint, color: Color(0xFF7B00D4), size: 56),
                const SizedBox(height: 16),
                Text(l.adminLockTitle,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const SizedBox(height: 8),
                Text(l.adminLockSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
                const SizedBox(height: 24),
                if (_checking)
                  const CircularProgressIndicator(color: Color(0xFF7B00D4))
                else ...[
                  ElevatedButton.icon(
                    onPressed: () { setState(() => _checking = true); _tryUnlock(); },
                    icon: const Icon(Icons.fingerprint),
                    label: Text(l.adminLockBtnRetry),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l.adminLockBtnCancel, style: const TextStyle(color: Color(0xFFAA9AB5))),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

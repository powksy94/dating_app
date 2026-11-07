import 'package:flutter/material.dart';
import 'package:nocturne/domains/admin/services/admin_status_service.dart';
import 'package:nocturne/domains/admin/widgets/admin_lock_gate.dart';
import 'package:nocturne/domains/home/views/home_page.dart';

/// Home, behind a fresh admin-link check every time it's built. Used both at
/// app launch (app.dart, an already-saved session) and after a fresh login
/// (roads.dart's '/home' route) — two separate entry points that would
/// otherwise each need their own admin check, and the second one did not
/// have one (login navigated straight to a bare HomePage, skipping the
/// fingerprint lock entirely for an admin-linked account).
class GatedHomePage extends StatefulWidget {
  const GatedHomePage({super.key});

  @override
  State<GatedHomePage> createState() => _GatedHomePageState();
}

class _GatedHomePageState extends State<GatedHomePage> {
  bool _checking = true;
  bool _isAdmin  = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final isAdmin = await AdminStatusService.isLinkedAdmin();
    if (mounted) setState(() { _isAdmin = isAdmin; _checking = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _isAdmin ? const AdminLockGate(child: HomePage()) : const HomePage();
  }
}

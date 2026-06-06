import 'package:flutter/material.dart';
import 'package:nocturne/domains/visit/services/visit_service.dart';
import 'package:nocturne/domains/visit/models/visitor.dart';
import 'package:nocturne/domains/visit/widgets/visitor_card.dart';
import 'package:nocturne/domains/subscription/widgets/paywall_sheet.dart';

class VisitorsPage extends StatefulWidget {
  const VisitorsPage({super.key});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  List<Visitor> _visitors = [];
  bool _loading   = true;
  bool _forbidden = false;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final result = await VisitService.getMyVisitors();
    if (!mounted) return;
    if (result.forbidden) {
      setState(() { _forbidden = true; _loading = false; });
      return;
    }
    final visitors = result.visitors.map(Visitor.fromJson).toList();
    setState(() { _visitors = visitors; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'VISITEURS',
          style: TextStyle(fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _forbidden
              ? _PaywallState()
              : _visitors.isEmpty
                  ? const _EmptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.72,
                      ),
                      itemCount: _visitors.length,
                      itemBuilder: (_, i) => VisitorCard(visitor: _visitors[i]),
                    ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) => const Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.remove_red_eye_outlined, size: 64, color: Color(0xFF7B00D4)),
      SizedBox(height: 16),
      Text('Personne n\'a encore visité ton profil', style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 16)),
    ]),
  );
}

class _PaywallState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, size: 56, color: Color(0xFF7B00D4)),
            const SizedBox(height: 16),
            const Text(
              'Fonctionnalité Nocturne',
              style: TextStyle(color: Color(0xFFE8E0EE), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Vois qui a visité ton profil ces 30 derniers jours en passant à Nocturne ou Abyssal.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => PaywallSheet.show(
                context,
                title: 'Visiteurs de profil',
                description: 'Découvre tous les profils qui ont consulté le tien.',
                requiredPlan: 'nocturne',
                icon: Icons.remove_red_eye,
              ),
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: const Text('Passer à Nocturne'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A0072),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF7B00D4)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

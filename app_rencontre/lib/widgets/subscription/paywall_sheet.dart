import 'package:flutter/material.dart';
import '../../views/subscription_page.dart';

class PaywallSheet extends StatelessWidget {
    final String title;
    final String description;
    final String requiredPlan;
    final IconData icon;

    const PaywallSheet({
        super.key,
        required this.title,
        required this.description,
        this.requiredPlan = 'Nocturne',
        this.icon = Icons.lock_outline,
    });

    static Future<void> show(
        BuildContext context, {
        required String title,
        required String description,
        String requiredPlan = 'Nocturne',
        IconData icon = Icons.lock_outline,
    }) {
        return showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => PaywallSheet(
                title: title, description: description,
                requiredPlan: requiredPlan, icon: icon,
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        final accent = requiredPlan.toLowerCase() == 'abyssal'
            ? const Color(0xFFD400FF)
            : const Color(0xFF7B00D4);

        return Container(
            decoration: const BoxDecoration(
                color: Color(0xFF1A0A1F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.fromLTRB(
                24, 20, 24, 24 + MediaQuery.of(context).padding.bottom),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Container(
                        width: 40, height: 4,
                        decoration: BoxDecoration(
                            color: const Color(0xFF3D2A4A),
                            borderRadius: BorderRadius.circular(2),
                        ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: accent, size: 30),
                    ),
                    const SizedBox(height: 16),
                    Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18,
                            fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFFAA9AB5), fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Disponible dès $requiredPlan',
                        style: TextStyle(
                            color: accent, fontSize: 13,
                            fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (_) => const SubscriptionPage()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                            ),
                            child: const Text(
                                'Voir les abonnements',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16,
                                    fontWeight: FontWeight.bold),
                            ),
                        ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                            'Pas maintenant',
                            style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 14),
                        ),
                    ),
                ],
            ),
        );
    }
}

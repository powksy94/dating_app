import 'package:flutter/material.dart';
import '../models/subscription_plan.dart';

class PlanCard extends StatelessWidget {
    final SubscriptionPlan plan;
    final bool isActive;
    final SubscriptionPeriod period;

    const PlanCard({
        super.key,
        required this.plan,
        required this.isActive,
        required this.period,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: plan.color,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                    color: isActive ? plan.accentColor : Colors.transparent,
                    width: 1.5,
                ),
                boxShadow: isActive
                    ? [BoxShadow(
                        color: plan.accentColor.withOpacity(0.3),
                        blurRadius: 24,
                        spreadRadius: 2,
                      )]
                    : [],
            ),
            child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Icon(plan.icon, color: plan.accentColor, size: 32),
                                if (plan.badge != null)
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: plan.accentColor,
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                            plan.badge!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                            ),
                                        ),
                                    ),
                            ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                            plan.name.toUpperCase(),
                            style: TextStyle(
                                color: plan.accentColor,
                                fontSize: 13,
                                letterSpacing: 2,
                            ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Text(
                                    plan.priceFor(period),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                if (!plan.isFree)
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5, left: 6),
                                        child: Text(
                                            periodLabel(period),
                                            style: const TextStyle(
                                                color: Color(0xFFAA9AB5),
                                                fontSize: 13,
                                            ),
                                        ),
                                    ),
                            ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFF3D2A4A)),
                        const SizedBox(height: 12),
                        Expanded(
                            child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: plan.features
                                .map((f) => _FeatureRow(feature: f, accentColor: plan.accentColor))
                                .toList(),
                            ),
                        ),
                    ],
                ),
            ),
        ),
    }
}

class _FeatureRow extends StatelessWidget {
    final SubscriptionFeature feature;
    final Color accentColor;
    const _FeatureRow({required this.feature, required this.accentColor});

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
                children: [
                    Icon(
                        feature.included ? Icons.check_circle : Icons.cancel_outlined,
                        size: 18,
                        color: feature.included ? accentColor : const Color(0xFF3D2A4A),
                    ),
                    const SizedBox(width: 10),
                    Text(
                        feature.label,
                        style: TextStyle(
                            color: feature.included
                                ? const Color(0xFFE8E0EE)
                                : const Color(0xFF5A4A6A),
                            fontSize: 14,
                        ),
                    ),
                ],
            ),
        ),
    }
}
import 'package:flutter/material.dart';
import '../models/subscription_plan.dart';

class PeriodSelector extends StatelessWidget {
    final SubscriptionPeriod selected;
    final Color accentColor;
    final ValueChanged<SubscriptionPeriod> onChanged;

    const PeriodSelector({
        super.key,
        required this.selected,
        required this.accentColor,
        required this.onChanged,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color(0xFF1A0A1F),
                borderRadius: BorderRadius.circular(14)
            ),
            child: Row(
                children: SubscriptionPeriod.values.map((p) {
                    final isSelected = selected == p;
                    final savings = periodSavings(p);
                    return Expanded(
                        child: GestureDetector(
                            onTap: () => onChanged(p),
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    color: isSelected ? accentColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Text(
                                            p == SubscriptionPeriod.week
                                                ? 'Semaine'
                                                : p == SubscriptionPeriod.month
                                                    ? 'Mois'
                                                    : 'An',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: isSelected ? Colors.white : const Color(0xFFAA9AB5),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                        if (savings != null)
                                        Text(
                                            savings,
                                            style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white.withOpacity(0.8)
                                                    : const Color(0xFF7B00D4),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    ),
                }).toList(),
            ),
        ),
    }
}
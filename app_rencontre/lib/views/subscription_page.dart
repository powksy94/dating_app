import 'package:flutter/material.dart';
import '../models/subscription_plan.dart';
import '../widgets/period_selector.dart';
import '../widgets/plan_card.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final _controller = PageController(viewportFraction: 0.88);
  int _current = 1;
  SubscriptionPeriod _period = SubscriptionPeriod.month;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlan = kSubscriptionPlans[_current];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'NOCTURNE PREMIUM',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Rejoins les ténèbres sans limites',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14, letterSpacing: 0.5),
            ),
          ),
          const SizedBox(height: 20),
          PeriodSelector(
            selected: _period,
            accentColor: currentPlan.accentColor,
            onChanged: (p) => setState(() => _period = p),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: kSubscriptionPlans.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, index) {
                final isActive = index == _current;
                return AnimatedScale(
                  scale: isActive ? 1.0 : 0.92,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: PlanCard(
                    plan: kSubscriptionPlans[index],
                    isActive: isActive,
                    period: _period,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(kSubscriptionPlans.length, (i) {
              final isActive = i == _current;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? currentPlan.accentColor : const Color(0xFF3D2A4A),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: currentPlan.isFree
                    ? null
                    : () {/* TODO: lancer le paiement */},
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentPlan.accentColor,
                  disabledBackgroundColor: const Color(0xFF3D2A4A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  currentPlan.isFree
                      ? 'Plan actuel'
                      : 'Choisir ${currentPlan.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Résiliation possible à tout moment',
            style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

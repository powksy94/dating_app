import 'package:flutter/material.dart';
import '../models/subscription_plan.dart';
import '../services/subscription_service.dart';
import '../widgets/subscription/period_selector.dart';
import '../widgets/subscription/plan_card.dart';
import '../widgets/subscription/subscription_action_button.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late PageController _controller;
  int _current               = 0;
  SubscriptionPeriod _period = SubscriptionPeriod.month;
  String _activePlan         = 'ombre';
  bool _loading              = true;

  @override
  void initState() {
    super.initState();
    _loadSubscription();
  }

  Future<void> _loadSubscription() async {
    final sub = await SubscriptionService.getMySubscription();
    final planNames = ['ombre', 'nocturne', 'abyssal'];
    final planIndex = planNames.indexOf(sub['plan'] ?? 'ombre');
    final periodMap = {
      'week':  SubscriptionPeriod.week,
      'month': SubscriptionPeriod.month,
      'year':  SubscriptionPeriod.year,
    };
    final period = periodMap[sub['period']] ?? SubscriptionPeriod.month;
    final index  = planIndex < 0 ? 0 : planIndex;

    _controller = PageController(viewportFraction: 0.88, initialPage: index);
    if (mounted) {
      setState(() {
        _current    = index;
        _period     = period;
        _activePlan = sub['plan'] ?? 'ombre';
        _loading    = false;
      });
    }
  }

  @override
  void dispose() {
    if (!_loading) _controller.dispose();
    super.dispose();
  }

  void _onSubscribed(String plan, SubscriptionPeriod period) {
    setState(() {
      _activePlan = plan;
      _period     = period;
    });
  }

  void _onCancelled() {
    setState(() {
      _activePlan = 'ombre';
      _current    = 0;
    });
    _controller.animateToPage(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D0010),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
              style: TextStyle(
                  color: Color(0xFFAA9AB5), fontSize: 14, letterSpacing: 0.5),
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
              itemBuilder: (_, index) => AnimatedScale(
                scale: index == _current ? 1.0 : 0.92,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: PlanCard(
                  plan: kSubscriptionPlans[index],
                  isActive: index == _current,
                  period: _period,
                ),
              ),
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
                  color: isActive
                      ? currentPlan.accentColor
                      : const Color(0xFF3D2A4A),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          SubscriptionActionButton(
            plan:        currentPlan,
            period:      _period,
            activePlan:  _activePlan,
            onSubscribed: _onSubscribed,
            onCancelled:  _onCancelled,
          ),
          SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

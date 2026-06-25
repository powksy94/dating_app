import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/domains/subscription/services/subscription_service.dart';
import 'package:nocturne/domains/subscription/widgets/period_selector.dart';
import 'package:nocturne/domains/subscription/widgets/plan_card.dart';
import 'package:nocturne/domains/subscription/widgets/subscription_action_button.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late PageController _controller;
  int _current                    = 0;
  SubscriptionPeriod _period      = SubscriptionPeriod.month;
  SubscriptionPeriod _activePeriod = SubscriptionPeriod.month;
  String _activePlan              = 'ombre';
  bool _loading                   = true;

  @override
  void initState() {
    super.initState();
    _loadSubscription();
  }

  Future<void> _loadSubscription() async {
    final sub = await SubscriptionService.getMySubscription();
    final planIndex = kSubscriptionPlanIds.indexOf(sub['plan'] ?? 'ombre');
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
        _current      = index;
        _period       = period;
        _activePeriod = period;
        _activePlan   = sub['plan'] ?? 'ombre';
        _loading      = false;
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
      _activePlan   = plan;
      _activePeriod = period;
      _period       = period;
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

    final plans = subscriptionPlans(context);
    final currentPlan = plans[_current];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.subscriptionPageTitle,
          style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              AppLocalizations.of(context)!.subscriptionPageSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFFAA9AB5), fontSize: 14, letterSpacing: 0.5),
            ),
          ),
          const SizedBox(height: 20),
          if (!currentPlan.isFree)
            PeriodSelector(
              selected: _period,
              accentColor: currentPlan.accentColor,
              onChanged: (p) => setState(() => _period = p),
            )
          else
            const SizedBox(height: 40),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: plans.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (_, index) => AnimatedScale(
                scale: index == _current ? 1.0 : 0.92,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: PlanCard(
                  plan: plans[index],
                  isActive: index == _current,
                  period: _period,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(plans.length, (i) {
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
            plan:         currentPlan,
            period:       _period,
            activePlan:   _activePlan,
            activePeriod: _activePeriod,
            onSubscribed: _onSubscribed,
            onCancelled:  _onCancelled,
          ),
          SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

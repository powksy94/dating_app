import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/domains/subscription/services/subscription_service.dart';
import 'package:nocturne/domains/subscription/widgets/subscription_dialogs.dart';

class SubscriptionActionButton extends StatefulWidget {
  final SubscriptionPlan plan;
  final SubscriptionPeriod period;
  final String activePlan;
  final SubscriptionPeriod activePeriod;
  final void Function(String plan, SubscriptionPeriod period) onSubscribed;
  final VoidCallback onCancelled;

  const SubscriptionActionButton({
    super.key,
    required this.plan,
    required this.period,
    required this.activePlan,
    required this.activePeriod,
    required this.onSubscribed,
    required this.onCancelled,
  });

  @override
  State<SubscriptionActionButton> createState() => _SubscriptionActionButtonState();
}

class _SubscriptionActionButtonState extends State<SubscriptionActionButton> {
  bool _loading = false;

  bool get _isCurrentPlan  => widget.plan.id == widget.activePlan;
  bool get _isPeriodSame   => widget.period == widget.activePeriod;
  bool get _isFullyActive  => _isCurrentPlan && _isPeriodSame;
  bool get _onPaidPlan     => widget.activePlan != 'ombre';

  String get _buttonLabel {
    final l = AppLocalizations.of(context)!;
    if (widget.plan.isFree)  return _onPaidPlan ? l.subscriptionBtnSwitchToFree : l.subscriptionBtnCurrentPlan;
    if (_isFullyActive)      return l.subscriptionBtnCurrentPlan;
    if (_isCurrentPlan)      return l.subscriptionBtnChangePeriod;
    return l.subscriptionBtnChoosePlan(widget.plan.name);
  }

  bool get _buttonEnabled {
    if (widget.plan.isFree) return _onPaidPlan && !_loading;
    return !_isFullyActive && !_loading;
  }

  Future<void> _onButtonPressed() {
    if (widget.plan.isFree) return _cancel();
    return _subscribe();
  }

  Future<void> _subscribe() async {
    final l = AppLocalizations.of(context)!;
    final ok = await SubscriptionDialogs.confirmSubscribe(context, widget.plan, widget.period);
    if (!ok || !mounted) return;

    setState(() => _loading = true);
    final success = await SubscriptionService.subscribe(
      widget.plan.id,
      widget.period.name,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (success) widget.onSubscribed(widget.plan.id, widget.period);
    _showSnack(
      success ? l.subscriptionSnackSubscribed(widget.plan.name) : l.subscriptionSnackError,
      success ? widget.plan.accentColor : const Color(0xFF7F1D1D),
    );
  }

  Future<void> _cancel() async {
    final l = AppLocalizations.of(context)!;
    final ok = await SubscriptionDialogs.confirmCancel(context);
    if (!ok || !mounted) return;

    setState(() => _loading = true);
    final success = await SubscriptionService.cancel();
    if (!mounted) return;
    setState(() => _loading = false);

    if (success) widget.onCancelled();
    _showSnack(
      success ? l.subscriptionSnackCancelled : l.subscriptionSnackError,
      success ? const Color(0xFF3D2A4A) : const Color(0xFF7F1D1D),
    );
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _buttonEnabled ? _onButtonPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.plan.accentColor,
                disabledBackgroundColor: const Color(0xFF3D2A4A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: _loading
                  ? const SizedBox(width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(_buttonLabel,
                      style: const TextStyle(color: Colors.white, fontSize: 16,
                          fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            ),
          ),
          if (_isCurrentPlan && !widget.plan.isFree) ...[
            const SizedBox(height: 10),
            TextButton(
              onPressed: _loading ? null : _cancel,
              child: Text(AppLocalizations.of(context)!.subscriptionCancelSubscription,
                  style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
            ),
          ] else ...[
            const SizedBox(height: 10),
            if (!widget.plan.isFree)
              Text(AppLocalizations.of(context)!.subscriptionCancelAnytimeNote,
                  style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 12))
            else
              const SizedBox(height: 15),
          ],
        ],
      ),
    );
  }
}

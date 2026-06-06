import 'package:flutter/material.dart';
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

  bool get _isCurrentPlan  => widget.plan.name.toLowerCase() == widget.activePlan;
  bool get _isPeriodSame   => widget.period == widget.activePeriod;
  bool get _isFullyActive  => _isCurrentPlan && _isPeriodSame;
  bool get _onPaidPlan     => widget.activePlan != 'ombre';

  String get _buttonLabel {
    if (widget.plan.isFree)  return _onPaidPlan ? 'Passer au plan gratuit' : '✓ Plan actuel';
    if (_isFullyActive)      return '✓ Plan actuel';
    if (_isCurrentPlan)      return 'Changer de période';
    return 'Choisir ${widget.plan.name}';
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
    final ok = await SubscriptionDialogs.confirmSubscribe(context, widget.plan, widget.period);
    if (!ok || !mounted) return;

    setState(() => _loading = true);
    final success = await SubscriptionService.subscribe(
      widget.plan.name.toLowerCase(),
      widget.period.name,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (success) widget.onSubscribed(widget.plan.name.toLowerCase(), widget.period);
    _showSnack(
      success ? '✓ Abonnement ${widget.plan.name} activé !' : 'Erreur, réessaie.',
      success ? widget.plan.accentColor : const Color(0xFF7F1D1D),
    );
  }

  Future<void> _cancel() async {
    final ok = await SubscriptionDialogs.confirmCancel(context);
    if (!ok || !mounted) return;

    setState(() => _loading = true);
    final success = await SubscriptionService.cancel();
    if (!mounted) return;
    setState(() => _loading = false);

    if (success) widget.onCancelled();
    _showSnack(
      success ? 'Abonnement résilié.' : 'Erreur, réessaie.',
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
              child: const Text('Résilier l\'abonnement',
                  style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12)),
            ),
          ] else ...[
            const SizedBox(height: 10),
            if (!widget.plan.isFree)
              const Text('Résiliation possible à tout moment',
                  style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12))
            else
              const SizedBox(height: 15),
          ],
        ],
      ),
    );
  }
}

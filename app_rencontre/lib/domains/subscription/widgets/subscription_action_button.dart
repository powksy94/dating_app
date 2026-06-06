import 'package:flutter/material.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/domains/subscription/services/subscription_service.dart';
import 'package:nocturne/domains/subscription/widgets/subscription_dialogs.dart';

class SubscriptionActionButton extends StatefulWidget {
  final SubscriptionPlan plan;
  final SubscriptionPeriod period;
  final String activePlan;
  final void Function(String plan, SubscriptionPeriod period) onSubscribed;
  final VoidCallback onCancelled;

  const SubscriptionActionButton({
    super.key,
    required this.plan,
    required this.period,
    required this.activePlan,
    required this.onSubscribed,
    required this.onCancelled,
  });

  @override
  State<SubscriptionActionButton> createState() => _SubscriptionActionButtonState();
}

class _SubscriptionActionButtonState extends State<SubscriptionActionButton> {
  bool _loading = false;

  bool get _isActive =>
      widget.plan.name.toLowerCase() == widget.activePlan;

  Future<void> _subscribe() async {
    final ok = await SubscriptionDialogs.confirmSubscribe(
        context, widget.plan, widget.period);
    if (!ok || !mounted) return;

    setState(() => _loading = true);
    final success = await SubscriptionService.subscribe(
      widget.plan.name.toLowerCase(),
      widget.period.name,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (success) {
      widget.onSubscribed(widget.plan.name.toLowerCase(), widget.period);
    }
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
    final isFree = widget.plan.isFree;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isFree || _isActive || _loading ? null : _subscribe,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.plan.accentColor,
                disabledBackgroundColor: const Color(0xFF3D2A4A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      isFree
                          ? 'Plan gratuit'
                          : _isActive
                              ? '✓ Plan actuel'
                              : 'Choisir ${widget.plan.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
            ),
          ),
          if (_isActive && !isFree) ...[
            const SizedBox(height: 10),
            TextButton(
              onPressed: _loading ? null : _cancel,
              child: const Text(
                'Résilier l\'abonnement',
                style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
              ),
            ),
          ] else ...[
            const SizedBox(height: 10),
            const Text(
              'Résiliation possible à tout moment',
              style: TextStyle(color: Color(0xFF5A4A6A), fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

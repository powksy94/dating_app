import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/subscription/models/subscription_plan.dart';
import 'package:nocturne/domains/subscription/services/restore_service.dart';

class RestorePurchasesButton extends StatefulWidget {
  final void Function(String plan, SubscriptionPeriod period) onRestored;

  const RestorePurchasesButton({super.key, required this.onRestored});

  @override
  State<RestorePurchasesButton> createState() => _RestorePurchasesButtonState();
}

class _RestorePurchasesButtonState extends State<RestorePurchasesButton> {
  bool _loading = false;

  Future<void> _onPressed() async {
    setState(() => _loading = true);
    final plan = await RestoreService.restore();
    if (!mounted) return;
    setState(() => _loading = false);

    final l = AppLocalizations.of(context)!;
    if (plan != null) widget.onRestored(plan, SubscriptionPeriod.month);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(plan != null ? l.subscriptionRestoreSuccess : l.subscriptionRestoreEmpty),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: _loading ? null : _onPressed,
        child: _loading
            ? const SizedBox(
                width: 16, height: 16,
                child: CircularProgressIndicator(strokeWidth: 2))
            : Text(
                AppLocalizations.of(context)!.subscriptionRestoreCta,
                style: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
              ),
      ),
    );
  }
}

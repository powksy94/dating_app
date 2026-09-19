import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/shared/widgets/common/load_error_view.dart';

class SwipeLoadError extends StatelessWidget {
  final VoidCallback onRetry;
  const SwipeLoadError({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return LoadErrorView(
      title: l.discoveryLoadErrorTitle,
      subtitle: l.discoveryLoadErrorSubtitle,
      retryLabel: l.discoveryBtnRetry,
      onRetry: onRetry,
    );
  }
}

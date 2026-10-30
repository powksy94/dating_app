import 'package:flutter/material.dart';

/// Shared header for every step of the report flow: a title (either the
/// flow's own title, or the selected category's label with a back button),
/// plus a close button.
class ReportFlowHeader extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  const ReportFlowHeader({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            if (showBack)
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 16, color: Color(0xFF5A4A6A)),
                onPressed: onBack,
              )
            else
              const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: Color(0xFF5A4A6A)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const Divider(color: Color(0xFF2D0040), height: 1),
      ],
    );
  }
}

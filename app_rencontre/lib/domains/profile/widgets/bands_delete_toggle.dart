import 'package:flutter/material.dart';

/// Red trash button that switches the bands list into delete mode. While the
/// mode is active it turns into a check that leaves it.
class BandsDeleteToggle extends StatelessWidget {
  final bool active;
  final VoidCallback onPressed;

  const BandsDeleteToggle({super.key, required this.active, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? const Color(0xFF7B00D4) : const Color(0xFFC62828),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            active ? Icons.check : Icons.delete_outline,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}

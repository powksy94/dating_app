import 'package:flutter/material.dart';

/// Two-segment switch between the suggestions built on what the two people share
/// and the classic icebreakers. Both labels are always visible (a lone button with
/// a long label got cut off), and the active one is highlighted.
class StarterModeToggle extends StatelessWidget {
  final bool classicSelected;
  final String sharedLabel;
  final String classicLabel;
  final ValueChanged<bool> onChanged;

  const StarterModeToggle({
    super.key,
    required this.classicSelected,
    required this.sharedLabel,
    required this.classicLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFF120018),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF3D2A4A)),
      ),
      child: Row(
        children: [
          _segment(sharedLabel, selected: !classicSelected, onTap: () => onChanged(false)),
          _segment(classicLabel, selected: classicSelected, onTap: () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _segment(String label, {required bool selected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF4A0072) : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: selected ? const Color(0xFF7B00D4) : Colors.transparent),
          ),
          child: Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF8A7A98),
              fontSize: 12.5,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

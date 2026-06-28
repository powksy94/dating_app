import 'package:flutter/material.dart';

class MessageReactionsRow extends StatelessWidget {
  final Map<String, List<String>> reactions;
  const MessageReactionsRow({super.key, required this.reactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Wrap(
        spacing: 4,
        children: reactions.entries.map((e) {
          final emoji = e.key;
          final count = e.value.length;
          if (count == 0) return const SizedBox.shrink();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF2D0040),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF3D2A4A)),
            ),
            child: Text('$emoji $count',
                style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
      ),
    );
  }
}

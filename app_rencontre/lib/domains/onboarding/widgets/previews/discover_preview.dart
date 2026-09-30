import 'package:flutter/material.dart';
import 'package:nocturne/shared/widgets/common/swipe_demo.dart';

class DiscoverPreview extends StatelessWidget {
  const DiscoverPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Color(0xFF0D0010), child: SwipeDemo());
  }
}

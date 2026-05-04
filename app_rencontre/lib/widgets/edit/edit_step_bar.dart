import 'package:flutter/material.dart';

class EditStepBar extends StatefulWidget {
  final int currentStep;
  final List<String> labels;
  final void Function(int) onStepTap;

  const EditStepBar({
    super.key,
    required this.currentStep,
    required this.labels,
    required this.onStepTap,
  });

  @override
  State<EditStepBar> createState() => _EditStepBarState();
}

class _EditStepBarState extends State<EditStepBar> {
  late final List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(widget.labels.length, (_) => GlobalKey());
  }

  @override
  void didUpdateWidget(EditStepBar old) {
    super.didUpdateWidget(old);
    if (old.currentStep != widget.currentStep) _scrollToActive();
  }

  void _scrollToActive() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _keys[widget.currentStep].currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(ctx,
          alignment: 0.5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(widget.labels.length, (i) {
          final isActive = i == widget.currentStep;
          return Row(
            children: [
              GestureDetector(
                key: _keys[i],
                onTap: () => widget.onStepTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: isActive ? 16 : 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF7B00D4) : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFF7B00D4)
                          : const Color(0xFF3D2A4A),
                    ),
                  ),
                  child: isActive
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${i + 1}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(width: 6),
                            Text(widget.labels[i],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      : Text('${i + 1}',
                          style: const TextStyle(
                              color: Color(0xFF5A4A6A),
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                ),
              ),
              if (i < widget.labels.length - 1)
                Container(
                  width: 20, height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  color: const Color(0xFF3D2A4A),
                ),
            ],
          );
        }),
      ),
    );
  }
}

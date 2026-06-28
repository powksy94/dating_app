import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ChipOption {
    final String value;
    final String label;
    const ChipOption(this.value, this.label);
}

class ChipSelector extends StatelessWidget {
    final String title;
    final List<ChipOption> options;
    final String? selected;
    final void Function(String) onSelected;
    final String otherValue;
    final String? customValue;
    final void Function(String)? onCustomChanged;
    final int fadeDelayMs;

    const ChipSelector({
        super.key,
        required this.title,
        required this.options,
        required this.selected,
        required this.onSelected,
        this.otherValue = 'other',
        this.customValue,
        this.onCustomChanged,
        this.fadeDelayMs = 500,
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    title,
                    style: const TextStyle(
                        color: Color(0xFF7B00D4),
                        fontSize: 12,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                    ),
                ).animate().fadeIn(delay: Duration(milliseconds: fadeDelayMs), duration: 400.ms),
                const SizedBox(height: 10),
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: options.map((option) => ChoiceChip(
                        label: Text(option.label),
                        selected: selected == option.value,
                        onSelected: (_) => onSelected(option.value),
                        selectedColor: const Color(0xFF7B00D4),
                    )).toList(),
                ).animate().fadeIn(delay: Duration(milliseconds: fadeDelayMs), duration: 400.ms),
                if (selected == otherValue) ...[
                    const SizedBox(height: 10),
                    TextField(
                        onChanged: onCustomChanged,
                        style: const TextStyle(color: Color(0xFFE8E0EE)),
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.authLabelSpecify,
                            filled: true,
                            fillColor: const Color(0xFF1A0A1F),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                    ),
                ],
            ],
        );
    }
}

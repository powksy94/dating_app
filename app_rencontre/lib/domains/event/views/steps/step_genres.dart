import 'package:flutter/material.dart';
import 'package:nocturne/core/music_tags.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class StepGenres extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;
  const StepGenres({super.key, required this.onNext});

  @override
  State<StepGenres> createState() => _StepGenresState();
}

class _StepGenresState extends State<StepGenres> {
  final List<String> _selected = [];

  void _next() {
    widget.onNext({'genres': _selected});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.eventStepGenresTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(l.eventStepGenresSubtitle,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: kMusicGenres.map((g) {
              final selected = _selected.contains(g);
              return GestureDetector(
                onTap: () => setState(() {
                  selected ? _selected.remove(g) : _selected.add(g);
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF7B00D4)
                        : const Color(0xFF1A0A1F),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF7B00D4)
                          : const Color(0xFF3D2A4A),
                    ),
                  ),
                  child: Text(g,
                      style: TextStyle(
                          color: selected
                              ? Colors.white
                              : const Color(0xFF5A4A6A),
                          fontSize: 13)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(l.eventBtnContinue,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

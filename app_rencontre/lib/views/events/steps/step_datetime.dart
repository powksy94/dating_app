import 'package:flutter/material.dart';

class StepDatetime extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;
  const StepDatetime({super.key, required this.onNext});

  @override
  State<StepDatetime> createState() => _StepDatetimeState();
}

class _StepDatetimeState extends State<StepDatetime> {
  DateTime? _date;
  String?   _error;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: Color(0xFF7B00D4)),
        ),
        child: child!,
      ),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 20, minute: 0),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: Color(0xFF7B00D4)),
        ),
        child: child!,
      ),
    );
    if (time == null) return;
    setState(() {
      _date = DateTime(
          date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _next() {
    if (_date == null) {
      setState(() => _error = 'Choisis une date et une heure');
      return;
    }
    widget.onNext({'date': _date});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quand a lieu l'événement ?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Date et heure de début',
              style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFF1A0A1F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _date != null
                      ? const Color(0xFF7B00D4)
                      : const Color(0xFF3D2A4A),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: _date != null
                        ? const Color(0xFF7B00D4)
                        : const Color(0xFF5A4A6A),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _date == null
                        ? 'Choisir une date et heure'
                        : '${_date!.day.toString().padLeft(2, '0')}/'
                            '${_date!.month.toString().padLeft(2, '0')}/'
                            '${_date!.year}  ·  '
                            '${_date!.hour.toString().padLeft(2, '0')}h'
                            '${_date!.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: _date == null
                          ? const Color(0xFF5A4A6A)
                          : Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!,
                style: const TextStyle(
                    color: Color(0xFFD400FF), fontSize: 12)),
          ],
          const Spacer(),
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
              child: const Text('Continuer',
                  style: TextStyle(
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

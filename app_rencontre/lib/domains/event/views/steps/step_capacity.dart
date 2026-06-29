import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class StepCapacity extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;
  const StepCapacity({super.key, required this.onNext});

  @override
  State<StepCapacity> createState() => _StepCapacityState();
}

class _StepCapacityState extends State<StepCapacity> {
  final _minCtrl = TextEditingController();
  final _maxCtrl = TextEditingController();
  bool    _isRange = false;
  String? _error;

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  void _next() {
    final capMin = int.tryParse(_minCtrl.text.trim());
    final capMax = _isRange ? int.tryParse(_maxCtrl.text.trim()) : null;

    if (capMin == null || capMin < 1) {
      setState(() => _error = AppLocalizations.of(context)!.eventErrorCapacityInvalid);
      return;
    }
    if (_isRange && (capMax == null || capMax <= capMin)) {
      setState(() => _error = AppLocalizations.of(context)!.eventErrorCapacityMaxMin);
      return;
    }
    widget.onNext({'capacityMin': capMin, 'capacityMax': capMax});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.eventStepCapacityTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(l.eventStepCapacitySubtitle,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 32),
          Row(
            children: [
              _toggle(l.eventToggleExactNumber, !_isRange,
                  () => setState(() => _isRange = false)),
              const SizedBox(width: 10),
              _toggle(l.eventToggleRange, _isRange,
                  () => setState(() => _isRange = true)),
            ],
          ),
          const SizedBox(height: 20),
          if (!_isRange)
            _field(_minCtrl, l.eventLabelExactPlaces)
          else
            Row(
              children: [
                Expanded(child: _field(_minCtrl, l.eventLabelMin)),
                const SizedBox(width: 12),
                Expanded(child: _field(_maxCtrl, l.eventLabelMax)),
              ],
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

  Widget _toggle(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF7B00D4) : const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active
                ? const Color(0xFF7B00D4)
                : const Color(0xFF3D2A4A),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? Colors.white : const Color(0xFF5A4A6A),
                fontSize: 13)),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0D0010),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF3D2A4A))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF7B00D4))),
      ),
    );
  }
}

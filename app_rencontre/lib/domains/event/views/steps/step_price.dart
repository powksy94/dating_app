import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class StepPrice extends StatefulWidget {
  final Future<void> Function(Map<String, dynamic>) onSubmit;
  const StepPrice({super.key, required this.onSubmit});

  @override
  State<StepPrice> createState() => _StepPriceState();
}

class _StepPriceState extends State<StepPrice> {
  final _priceCtrl = TextEditingController();
  bool    _isFree  = true;
  bool    _loading = false;
  String? _error;

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final price = _isFree ? null : double.tryParse(_priceCtrl.text.trim());

    if (!_isFree && price == null) {
      setState(() => _error = AppLocalizations.of(context)!.eventErrorPriceInvalid);
      return;
    }

    setState(() { _loading = true; _error = null; });
    await widget.onSubmit({'isFree': _isFree, 'price': price});
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.eventStepPriceTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(l.eventStepPriceSubtitle,
              style: const TextStyle(color: Color(0xFFAA9AB5), fontSize: 13)),
          const SizedBox(height: 32),
          Row(
            children: [
              _toggle(l.eventPriceFree, _isFree,
                  () => setState(() => _isFree = true)),
              const SizedBox(width: 12),
              _toggle(l.eventTogglePaid, !_isFree,
                  () => setState(() => _isFree = false)),
            ],
          ),
          if (!_isFree) ...[
            const SizedBox(height: 20),
            TextField(
              controller: _priceCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                labelText: l.eventLabelPriceRequired,
                labelStyle:
                    const TextStyle(color: Color(0xFF5A4A6A), fontSize: 13),
                suffixText: '€',
                suffixStyle: const TextStyle(
                    color: Color(0xFF7B00D4), fontSize: 16),
                filled: true,
                fillColor: const Color(0xFF0D0010),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFF3D2A4A))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFF3D2A4A))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFF7B00D4))),
              ),
            ),
          ],
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
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B00D4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: _loading
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                  : Text(l.eventBtnSubmit,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                fontSize: 13,
                fontWeight:
                    active ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }
}

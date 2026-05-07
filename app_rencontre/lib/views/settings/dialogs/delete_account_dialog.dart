import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';

class DeleteAccountDialog extends StatefulWidget{
  final String username;
  const DeleteAccountDialog({super.key, required this.username});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _ctrl  = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _confirmed => _ctrl.text == widget.username;

  Future<void> _delete() async {
    setState(() { _loading = true; _error = null; });
    final err = await AuthService().deleteAccount();
    if (!mounted) return;
    if (err == null) {
      final nav = Navigator.of(context);
      Navigator.pop(context);
      nav.pushReplacementNamed('/login');
    } else {
      setState(() { _loading = false; _error = err; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1A0A1F),
      title: const Text(
        'Supprimer le compte',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cette action est irréversible.\nTape ton pseudo pour confirmer.',
            style: TextStyle(color: Color(0xFFAA9AB5)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ctrl,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.username,
              hintStyle: const TextStyle(color: Color(0xFF5A4A6A)),
              filled: true,
              fillColor: const Color(0xFF0D0010),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF3D2A4A)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF3D2A4A)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF8B0000)),
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(_error!,
                style: const TextStyle(
                    color: Color(0xFF8B0000), fontSize: 12)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('Annuler',
              style: TextStyle(color: Color(0xFF7B00D4))),
        ),
        TextButton(
          onPressed: (_confirmed && !_loading) ? _delete : null,
          child: _loading
              ? const SizedBox(
                  width: 16, height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Color(0xFF8B0000)))
              : Text(
                  'Supprimer définitivement',
                  style: TextStyle(
                    color: _confirmed
                        ? const Color(0xFF8B0000)
                        : const Color(0xFF3D2A4A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}
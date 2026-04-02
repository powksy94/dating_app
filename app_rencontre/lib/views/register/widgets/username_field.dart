import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import '../../../../services/api_service.dart';

class UsernameField extends StatefulWidget {
    final TextEditingController controller;
    final void Function(String? status) onStatusChanged;

    const UsernameField({
        super.key,
        required this.controller,
        required this.onStatusChanged,
    });

    @override
    State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
    String? _status;
    Timer? _debounce;

    @override
    void dispose() {
        _debounce?.cancel();
        super.dispose();
    }

    void _onChanged(String value) {
        _debounce?.cancel();
        if (value.trim().length < 3) {
            setState(() => _status = null);
            widget.onStatusChanged(null);
            return;
        }
        setState(() => _status = 'checking');
        widget.onStatusChanged('checking');
        _debounce = Timer(
            const Duration(milliseconds: 600),
            () => _checkUsername(value.trim()),
        );
    }

    Future<void> _checkUsername(String username) async {
        try {
            final res = await http.get(
                Uri.parse('${ApiService.baseUrl}/auth/check-username?username=$username'),
            ).timeout(const Duration(seconds: 5));
            if (!mounted) return;
            final data = jsonDecode(res.body);
            if (res.statusCode == 200) {
                final status = data['available'] == true ? 'available' : 'taken';
                setState(() => _status = status);
                widget.onStatusChanged(status);
            } else {
                setState(() => _status = 'invalid');
                widget.onStatusChanged('invalid');
            }
        } catch (e) {
            debugPrint('checkUsername error: $e');
            if (!mounted) return;
            setState(() => _status = null);
            widget.onStatusChanged(null);
        }
    }

    Widget _icon() {
        switch (_status) {
            case 'checking':  return const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2));
            case 'available': return const Icon(Icons.check_circle, color: Colors.green, size: 20);
            case 'taken':     return const Icon(Icons.cancel, color: Color(0xFF8B0000), size: 20);
            case 'invalid':   return const Icon(Icons.warning, color: Colors.orange, size: 20);
            default:          return const SizedBox.shrink();
        }
    }

    @override
    Widget build(BuildContext context) {
        return TextField(
            controller: widget.controller,
            onChanged: _onChanged,
            style: const TextStyle(color: Color(0xFFE8E0EE)),
            decoration: InputDecoration(
                labelText: 'Pseudo',
                suffixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: _icon(),
                ),
                filled: true,
                fillColor: const Color(0xFF1A0A1F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
        ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
    }
}

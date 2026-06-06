import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:nocturne/domains/auth/widgets/animated_step.dart';

class StepPhotos extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepPhotos({super.key, required this.onNext});

    @override
    State<StepPhotos> createState() => _StepPhotosState();
}

class _StepPhotosState extends State<StepPhotos> {
    final List<XFile> _photos = [];
    final _picker = ImagePicker();
    String? _error;

    Future<void> _pickPhoto() async {
        if (_photos.length >= 6) return;
        final picked = await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 80,
        );
        if (picked != null) setState(() => _photos.add(picked));
    }

    void _removePhoto(int index) {
        setState(() => _photos.removeAt(index));
    }

    void _next() {
        if (_photos.isEmpty) {
            setState(() => _error = 'Ajoute au moins une photo.');
            return;
        }
        widget.onNext({'photos': _photos.map((f) => f.path).toList()});
    }

    @override
    Widget build(BuildContext context) {
        return AnimatedStep(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(height: 32),
                        const Text(
                            'Tes photos',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE8E0EE),
                            ),
                        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                        const SizedBox(height: 8),
                        const Text(
                            'Ajoute jusq\'à 6 photos. La première sera ta photo principale.',
                            style: TextStyle(color: Color(0xFFAA9AB5), fontSize: 14),
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                        const SizedBox(height: 32),

                        Expanded(
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                ),
                                itemCount: _photos.length < 6 ? _photos.length + 1 : 6,
                                itemBuilder: (context, index) {
                                    if (index == _photos.length) {
                                        return GestureDetector(
                                            onTap: _pickPhoto,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF1A0A1F),
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                        color: const Color(0xFF7B00D4),
                                                        width: 1.5,
                                                    ),
                                                ),
                                                child: const Icon(
                                                    Icons.add_a_photo,
                                                    color: Color(0xFF7B00D4),
                                                    size: 32,
                                                ),
                                            ),
                                        );
                                    }
                                    return Stack(
                                        fit: StackFit.expand,
                                        children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.file(
                                                    File(_photos[index].path),
                                                    fit: BoxFit.cover,
                                                ),
                                            ),
                                            Positioned(
                                                top: 4, right: 4,
                                                child: GestureDetector(
                                                    onTap: () => _removePhoto(index),
                                                    child: Container(
                                                        padding: const EdgeInsets.all(4),
                                                        decoration: const BoxDecoration(
                                                            color: Color(0xFF8B0000),
                                                            shape: BoxShape.circle,
                                                        ),
                                                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                                                    ),
                                                ),
                                            ),
                                            if (index == 0)
                                                Positioned(
                                                    bottom: 4, left: 4,
                                                    child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xFF7B00D4),
                                                            borderRadius: BorderRadius.circular(6),
                                                        ),
                                                        child: const Text(
                                                            'Principale',
                                                            style: TextStyle(color: Colors.white, fontSize: 10),
                                                        ),
                                                    ),
                                                ),
                                        ],
                                    );
                                },
                            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                        ),

                        if (_error != null) ...[
                            const SizedBox(height: 12),
                            Text(_error!, style: const TextStyle(color: Color(0xFF8B0000), fontSize: 13)),
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _next,
                                child: const Text('Continuer'),
                            ),
                        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
                        const SizedBox(height: 32),
                    ],
                ),
            ),
        );
    }
}
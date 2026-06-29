import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class ProfilePhotoViewer extends StatefulWidget {
  final List<String> photos;
  final int initialIndex;
  final int limit;
  final VoidCallback onUnlock;

  const ProfilePhotoViewer({
    super.key,
    required this.photos,
    required this.initialIndex,
    required this.limit,
    required this.onUnlock,
  });

  @override
  State<ProfilePhotoViewer> createState() => _ProfilePhotoViewerState();
}

class _ProfilePhotoViewerState extends State<ProfilePhotoViewer> {
  late final PageController _ctrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _ctrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: SafeArea(
            child: Center(
              child: GestureDetector(
                // absorbe le tap sur la carte pour ne pas fermer
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: 540,
                      child: Stack(
                        children: [
                          // Photos
                          PageView.builder(
                            controller: _ctrl,
                            itemCount: widget.photos.length,
                            onPageChanged: (i) =>
                                setState(() => _current = i),
                            itemBuilder: (context, index) {
                              final locked = index >= widget.limit;
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    widget.photos[index],
                                    fit: BoxFit.cover,
                                  ),
                                  if (locked) ...[
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 22, sigmaY: 22),
                                      child: Container(
                                          color: Colors.black.withValues(alpha: 0.35)),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.lock,
                                              color: Color(0xFF7B00D4),
                                              size: 40),
                                          const SizedBox(height: 12),
                                          ElevatedButton(
                                            onPressed: widget.onUnlock,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF7B00D4),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Text(l.profileBtnUnlockPremium),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),

                          // Points en bas
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.photos.length,
                                (i) {
                                  final isActive = i == _current;
                                  return AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    width: isActive ? 20 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? const Color(0xFF7B00D4)
                                          : Colors.white38,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/register/star_field.dart';
import '../../widgets/register/moon_glow.dart';

class RegistrationSuccessPage extends StatefulWidget {
  const RegistrationSuccessPage({super.key});

  @override
  State<RegistrationSuccessPage> createState() => _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowCtrl;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 3600), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04000A),
      body: Stack(
        children: [
          _AnimatedBackground(glowCtrl: _glowCtrl),
          const Positioned.fill(child: StarField()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonGlow(glowCtrl: _glowCtrl),
                const SizedBox(height: 48),
                const Text(
                  'BIENVENUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.4,
                      end: 0,
                      delay: 600.ms,
                      duration: 600.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 10),
                const Text(
                  'dans les ténèbres',
                  style: TextStyle(
                    color: Color(0xFF9D2FE8),
                    fontSize: 15,
                    letterSpacing: 4,
                    fontStyle: FontStyle.italic,
                  ),
                ).animate().fadeIn(delay: 950.ms, duration: 600.ms),
                const SizedBox(height: 64),
                _PulsingDots(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  final AnimationController glowCtrl;
  const _AnimatedBackground({required this.glowCtrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowCtrl,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.15),
            radius: 0.7 + glowCtrl.value * 0.15,
            colors: [
              Color.lerp(
                const Color(0xFF1A004A),
                const Color(0xFF2D0070),
                glowCtrl.value,
              )!,
              const Color(0xFF04000A),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulsingDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          color: Color(0xFF7B00D4),
          shape: BoxShape.circle,
        ),
      )
          .animate(delay: Duration(milliseconds: 1300 + i * 180))
          .scale(
            begin: const Offset(0, 0),
            end: const Offset(1, 1),
            duration: 300.ms,
            curve: Curves.easeOut,
          )
          .fadeIn(duration: 300.ms)
          .then()
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeOut(duration: Duration(milliseconds: 500 + i * 120))
          .then()
          .fadeIn(duration: Duration(milliseconds: 500 + i * 120))),
    );
  }
}

import 'package:flutter/material.dart';
import 'match_avatars_row.dart';
import 'match_particles.dart';
import '../../models/alternative_profile.dart';

// ─── Textes personnalisables ───────────────────────────────────────────────────
const kElegieMatchTitle    = 'TON ÉLÉGIE A ÉTÉ ENTENDUE';
const kElegieMatchSubtitle = 'Les ténèbres ont exaucé ta prière';
// ──────────────────────────────────────────────────────────────────────────────

class MatchOverlay extends StatefulWidget {
    final AlternativeProfile matchedProfile;
    final String? myAvatarUrl;
    final VoidCallback? onMessage;
    final bool isElegieMatch;
    final String? elegieText;

    const MatchOverlay({
        super.key,
        required this.matchedProfile,
        this.myAvatarUrl,
        this.onMessage,
        this.isElegieMatch = false,
        this.elegieText,
    });

    @override
    State<MatchOverlay> createState() => _MatchOverlayState();
}

class _MatchOverlayState extends State<MatchOverlay>
    with TickerProviderStateMixin {
        late final AnimationController _bgCtrl;
        late final AnimationController _avatarsCtrl;
        late final AnimationController _glowCtrl;
        late final AnimationController _textCtrl;
        late final AnimationController _buttonsCtrl;
        late final AnimationController _particlesCtrl;

        late final Animation<double> _bgFade;
        late final Animation<double> _slideAnim;
        late final Animation<double> _glowPulse;
        late final Animation<double> _textFade;
        late final Animation<double> _buttonsFade;
        late final Animation<double> _particlesFade;

        @override
        void initState() {
            super.initState();

            _bgCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
            _avatarsCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
            _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
                ..repeat(reverse: true);
            _textCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
            _buttonsCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
            _particlesCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

            _bgFade        = CurvedAnimation(parent: _bgCtrl,       curve: Curves.easeIn);
            _slideAnim     = CurvedAnimation(parent: _avatarsCtrl,  curve: Curves.easeOutCubic);
            _glowPulse     = CurvedAnimation(parent: _glowCtrl,     curve: Curves.easeInOut);
            _textFade      = CurvedAnimation(parent: _textCtrl,     curve: Curves.easeIn);
            _buttonsFade   = CurvedAnimation(parent: _buttonsCtrl,  curve: Curves.easeIn);
            _particlesFade = CurvedAnimation(parent: _particlesCtrl, curve: Curves.easeIn);

            _runSequence();
        }

        Future<void> _runSequence() async {
            await _bgCtrl.forward();
            _particlesCtrl.forward();
            await _avatarsCtrl.forward();
            await Future.delayed(const Duration(milliseconds: 200));
            await _textCtrl.forward();
            await Future.delayed(const Duration(milliseconds: 200));
            await _buttonsCtrl.forward();
        }

        @override
        void dispose() {
            _bgCtrl.dispose();
            _avatarsCtrl.dispose();
            _glowCtrl.dispose();
            _textCtrl.dispose();
            _buttonsCtrl.dispose();
            _particlesCtrl.dispose();
            super.dispose();
        }

        @override
        Widget build(BuildContext context) {
            return Scaffold(
            backgroundColor: Colors.transparent,
            body: AnimatedBuilder(
                animation: Listenable.merge([
                _bgFade, _slideAnim, _glowPulse,
                _textFade, _buttonsFade, _particlesFade,
                ]),
                builder: (context, _) {
                return Stack(
                    children: [
                    // Fond gradient
                    Opacity(
                        opacity: _bgFade.value,
                        child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                                Color(0xEE0D0010),
                                Color(0xEE1A0030),
                                Color(0xEE0D0010),
                            ],
                            ),
                        ),
                        ),
                    ),

                    // Particules
                    Opacity(
                        opacity: _particlesFade.value,
                        child: const MatchParticles(),
                    ),

                    // Contenu
                    SafeArea(
                        child: Column(
                        children: [
                            const Spacer(),

                            // Titre
                            Opacity(
                            opacity: _textFade.value,
                            child: Transform.translate(
                                offset: Offset(0, 20 * (1 - _textFade.value)),
                                child: Column(
                                children: [
                                    Text(
                                    widget.isElegieMatch ? kElegieMatchTitle : 'UN LIEN OBSCUR',
                                    style: TextStyle(
                                        color: const Color(0xFF7B00D4),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4,
                                        shadows: [
                                        Shadow(
                                            color: const Color(0xFF7B00D4).withValues(alpha: 0.8),
                                            blurRadius: 12,
                                        ),
                                        ],
                                    ),
                                    ),
                                    if (!widget.isElegieMatch) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                        'EST NÉ',
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 6,
                                        shadows: [
                                            Shadow(
                                            color: const Color(0xFF7B00D4).withValues(alpha: 0.6),
                                            blurRadius: 20,
                                            ),
                                        ],
                                        ),
                                    ),
                                    ],
                                ],
                                ),
                            ),
                            ),

                            const SizedBox(height: 48),

                            // Avatars
                            MatchAvatarRow(
                            myAvatarUrl: widget.myAvatarUrl ?? '',
                            matchAvatarUrl: widget.matchedProfile.avatarUrl,
                            matchUsername: widget.matchedProfile.username,
                            slideValue: _slideAnim.value,
                            glowValue: _glowPulse.value,
                            ),

                            const SizedBox(height: 16),

                            // Sous-titre
                            Opacity(
                            opacity: _textFade.value,
                            child: Text(
                                widget.isElegieMatch
                                    ? kElegieMatchSubtitle
                                    : 'Toi & ${widget.matchedProfile.username} êtes liés par les ténèbres',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                color: Color(0xFFAA9AB5),
                                fontSize: 14,
                                ),
                            ),
                            ),

                            // Texte de l'élégie
                            if (widget.isElegieMatch && widget.elegieText != null) ...[
                              const SizedBox(height: 16),
                              Flexible(
                                child: Opacity(
                                  opacity: _textFade.value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32),
                                    child: SingleChildScrollView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1A0030),
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: const Color(0xFF7B00D4),
                                            width: 0.8,
                                          ),
                                        ),
                                        child: Text(
                                          '"${widget.elegieText}"',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFFAA9AB5),
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],

                            const Spacer(),

                            // Boutons
                            Opacity(
                            opacity: _buttonsFade.value,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                children: [
                                    SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          widget.onMessage?.call();
                                        },
                                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                                        label: const Text(
                                        'ENVOYER UN MESSAGE',
                                        style: TextStyle(
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF7B00D4),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14),
                                        ),
                                        ),
                                    ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                        'Continuer à explorer',
                                        style: TextStyle(
                                        color: Color(0xFF5A4A6A),
                                        fontSize: 14,
                                        ),
                                    ),
                                    ),
                                ],
                                ),
                            ),
                            ),
                            const SizedBox(height: 24),
                        ],
                        ),
                    ),
                    ],
                );
                },
            ),
        );
    }
}
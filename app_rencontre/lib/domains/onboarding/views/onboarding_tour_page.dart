import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/onboarding/models/onboarding_tour_step.dart';
import 'package:nocturne/domains/onboarding/widgets/onboarding_tour_slide.dart';
import 'package:nocturne/domains/onboarding/widgets/onboarding_tour_dots.dart';
import 'package:nocturne/domains/onboarding/widgets/previews/discover_preview.dart';
import 'package:nocturne/domains/onboarding/widgets/previews/events_preview.dart';
import 'package:nocturne/domains/onboarding/widgets/previews/messages_preview.dart';
import 'package:nocturne/domains/onboarding/widgets/previews/profile_preview.dart';

/// Shown once, right after registration, before the user ever reaches Home:
/// a short feature tour so the navigation bar's tabs aren't a mystery on
/// first launch (see nocturne_feedback.pdf, "User Onboarding").
class OnboardingTourPage extends StatefulWidget {
  const OnboardingTourPage({super.key});

  @override
  State<OnboardingTourPage> createState() => _OnboardingTourPageState();
}

class _OnboardingTourPageState extends State<OnboardingTourPage> {
  final _controller = PageController();
  int _page = 0;

  List<OnboardingTourStep> _steps(AppLocalizations l) => [
        OnboardingTourStep(
          preview: const DiscoverPreview(),
          color: const Color(0xFF7B00D4),
          title: l.onboardingTourTitle1,
          subtitle: l.onboardingTourSubtitle1,
        ),
        OnboardingTourStep(
          preview: const EventsPreview(),
          color: const Color(0xFFB667FF),
          title: l.onboardingTourTitle2,
          subtitle: l.onboardingTourSubtitle2,
        ),
        OnboardingTourStep(
          preview: const MessagesPreview(),
          color: const Color(0xFF9D2FE8),
          title: l.onboardingTourTitle3,
          subtitle: l.onboardingTourSubtitle3,
        ),
        OnboardingTourStep(
          preview: const ProfilePreview(),
          color: const Color(0xFF5A2E8C),
          title: l.onboardingTourTitle4,
          subtitle: l.onboardingTourSubtitle4,
        ),
      ];

  void _finish() => Navigator.pushReplacementNamed(context, '/home');

  void _next(int lastIndex) {
    if (_page == lastIndex) {
      _finish();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final steps = _steps(l);
    final lastIndex = steps.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF04000A),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: _finish,
                  child: Text(l.onboardingTourSkip, style: const TextStyle(color: Color(0xFF5A4A6A))),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: steps.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => OnboardingTourSlide(step: steps[i]),
              ),
            ),
            OnboardingTourDots(count: steps.length, activeIndex: _page),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _next(lastIndex),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B00D4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    _page == lastIndex ? l.onboardingTourGetStarted : l.onboardingTourNext,
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

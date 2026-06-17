import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:nocturne/shared/widgets/common/step_progress_bar.dart';
import 'package:nocturne/domains/auth/views/register/steps/step_credentials.dart';
import 'package:nocturne/domains/auth/views/register/steps/step_identity.dart';
import 'package:nocturne/domains/auth/views/register/steps/step_photos.dart';
import 'package:nocturne/domains/auth/views/register/steps/step_tags.dart';
import 'package:nocturne/domains/auth/views/register/steps/step_location.dart';
import 'package:nocturne/domains/auth/views/register/steps/step_preferences.dart';

class RegisterFlow extends StatefulWidget {
    const RegisterFlow({super.key});

    @override
    State<RegisterFlow> createState() => _RegisterFlowState();
}

class _RegisterFlowState extends State<RegisterFlow> {
    final PageController _pageController = PageController();
    int _currentStep = 1;
    final int _totalSteps = 6;

    // Données accumulées sur tout le parcours
    final Map<String, dynamic> _data = {};

    @override
    void initState() {
        super.initState();
        ScreenProtector.protectDataLeakageOn();
    }

    void nextStep(Map<String, dynamic> stepData) {
        _data.addAll(stepData);
        if (_currentStep < _totalSteps) {
            setState(() => _currentStep++);
            _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
            );
        }
    }

    void previousStep() {
        if (_currentStep > 1) {
            setState(() => _currentStep--);
            _pageController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
            );
        }
    }

    @override
    void dispose() {
        ScreenProtector.protectDataLeakageOff();
        _pageController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: const Color(0xFF0D0010),
            appBar: AppBar(
                backgroundColor: const Color(0xFF0D0010),
                elevation: 0,
                leading: _currentStep > 1
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFAA9AB5)),
                        onPressed: previousStep,
                      )
                    : const SizedBox.shrink(),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: StepProgressBar(
                        currentStep: _currentStep,
                        totalSteps: _totalSteps,
                    ),
                ),
            ),
            body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                    StepCredentials(onNext: nextStep),
                    StepIdentity(onNext: nextStep),
                    StepPhotos(onNext: nextStep),
                    StepTags(onNext: nextStep),
                    StepLocation(onNext: nextStep),
                    StepPreferences(data: _data, onNext: nextStep),
                ],
            ),
        );
    }
}
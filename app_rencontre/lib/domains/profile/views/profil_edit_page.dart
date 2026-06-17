import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:nocturne/domains/profile/models/alternative_profile.dart';
import 'package:nocturne/shared/widgets/edit/edit_step_bar.dart';
import 'package:nocturne/domains/profile/views/edit/edit_step_identity.dart';
import 'package:nocturne/domains/profile/views/edit/edit_step_photos.dart';
import 'package:nocturne/domains/profile/views/edit/edit_step_tags.dart';
import 'package:nocturne/domains/profile/views/edit/edit_step_location.dart';
import 'package:nocturne/domains/profile/views/edit/edit_step_preferences.dart';

class ProfileEditPage extends StatefulWidget {
  final AlternativeProfile profile;
  const ProfileEditPage({super.key, required this.profile});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _pageController = PageController();
  int _currentStep = 0;

  static const _labels = [
    'Identité', 'Photos', 'Tags', 'Lieu', 'Préférences',
  ];

  @override
  void initState() {
    super.initState();
    ScreenProtector.protectDataLeakageOn();
  }

  void _goToStep(int index) {
    setState(() => _currentStep = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
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
        title: const Text(
          'ÉDITER MON PROFIL',
          style: TextStyle(
              fontSize: 13,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF120018),
              border: Border(
                  bottom: BorderSide(color: Color(0xFF2D0040))),
            ),
            child: EditStepBar(
              currentStep: _currentStep,
              labels: _labels,
              onStepTap: _goToStep,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                EditStepIdentity(profile: widget.profile),
                EditStepPhotos(profile: widget.profile),
                EditStepTags(profile: widget.profile),
                EditStepLocation(profile: widget.profile),
                EditStepPreferences(profile: widget.profile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

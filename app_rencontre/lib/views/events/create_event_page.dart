import 'package:flutter/material.dart';
import '../../services/event_service.dart';
import '../../widgets/step_progress_bar.dart';
import 'steps/step_cover_info.dart';
import 'steps/step_datetime.dart';
import 'steps/step_location.dart';
import 'steps/step_genres.dart';
import 'steps/step_capacity.dart';
import 'steps/step_price.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _pageController = PageController();
  int _currentStep = 1;
  final int _totalSteps = 6;
  final Map<String, dynamic> _data = {};
  bool _submitting = false;

  void _nextStep(Map<String, dynamic> stepData) {
    _data.addAll(stepData);
    if (_currentStep < _totalSteps) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submit(Map<String, dynamic> lastStepData) async {
    _data.addAll(lastStepData);
    setState(() => _submitting = true);

    final err = await EventService.createEvent(
      title:          _data['title'],
      description:    _data['description'],
      date:           _data['date'],
      city:           _data['city'],
      address:        _data['address'],
      lat:            _data['lat'],
      lng:            _data['lng'],
      genres:         List<String>.from(_data['genres'] ?? []),
      capacityMin:    _data['capacityMin'],
      capacityMax:    _data['capacityMax'],
      isFree:         _data['isFree'],
      price:          _data['price'],
      coverImagePath: _data['coverPath'],
    );

    if (!mounted) return;
    setState(() => _submitting = false);

    if (err == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Événement soumis pour modération'),
          backgroundColor: Color(0xFF7B00D4),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
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
                icon: const Icon(Icons.arrow_back_ios,
                    color: Color(0xFFAA9AB5)),
                onPressed: _previousStep,
              )
            : const SizedBox.shrink(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: StepProgressBar(
            currentStep: _currentStep,
            totalSteps:  _totalSteps,
          ),
        ),
      ),
      body: _submitting
          ? const Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StepCoverInfo(onNext: _nextStep),
                StepDatetime(onNext: _nextStep),
                StepLocation(onNext: _nextStep),
                StepGenres(onNext: _nextStep),
                StepCapacity(onNext: _nextStep),
                StepPrice(onSubmit: _submit),
              ],
            ),
    );
  }
}

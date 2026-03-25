import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import '../widgets/animated_step.dart';

class StepPreferences extends StatefulWidget {
    final Map<String, dynamic> data;
    final void Function(Map<String, dynamic>) onNext;
    const StepPreferences({super.key, required this.data, required this.onNext});

    @override
    State<StepPreferences> createState() => _StepPreferencesState();
}

class _StepPreferencesState extends State<StepPreferences> {
    RangesValues _ageRange = const RangesValues(18, 40);
    double _maxDistance = 50;
    List<String> _genderPrefs = [];
    bool _loading = false;
    String? _error;

    static const _genders = [
        'Homme', 'Femme', 'Nom-binaire', 'Genderfluid',
        'Agenre', 'Transmasculin', 'Transféminin', 'Tous',
    ];

    void _toggleGender(String g) {
        setState(() => _genderPrefs.contains(g)
        ? _genderPrefs.remove(g)
        : _genderPrefs.add(g));
    }

    //soon
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../services/api_service.dart';
import '../widgets/animated_step.dart';

class StepIdentity extends StatefulWidget {
    final void Function(Map<String, dynamic>) onNext;
    const StepIdentity({super.key, required this.onNext});

    @override
    State<StepIdentity> createState() => _StepIdentityState();
}

class _StepIdentityState extends State<StepIdentity> {
    final _usernameCtrl = TextEditingController();
    Datetime? _birthDate;
    String? _gender;
    String? _genderCustom;
    String? _pronouns;
    String? _pronounsCustom;
    String? _error;
    String? _usernameStatus; // 'checking', 'available', 'taken', 'invalid
    Timer? _debounce
}
// soon
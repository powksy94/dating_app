import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/gamer_profile.dart';

class ProfileEditPage extends StatefulWidget {
  final GamerProfile profile;

  const ProfileEditPage({super.key, required this.profile});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    widget.profile.externalProfiles.forEach((game, url) {
      _controllers[game] = TextEditingController(text: url);
    });
  }

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  Future<void> _saveUrls() async {
    if (!_formKey.currentState!.validate()) return;

    final Map<String, String> updatedUrls = {};
    _controllers.forEach((game, controller) {
      if (controller.text.trim().isNotEmpty) updatedUrls[game] = controller.text.trim();
    });

    await FirebaseFirestore.instance.collection('users').doc(widget.profile.uid).set(
      {'externalProfiles': updatedUrls},
      SetOptions(merge: true),
    );

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('URLs mises à jour !')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final games = widget.profile.gameRanks.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Éditer le profil'), backgroundColor: Colors.black87),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (_, index) {
                    final game = games[index];
                    _controllers.putIfAbsent(game, () => TextEditingController());
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        controller: _controllers[game],
                        decoration: InputDecoration(
                          labelText: "$game - URL profil externe",
                          filled: true,
                          fillColor: Colors.grey[800],
                          labelStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value != null && value.isNotEmpty && Uri.tryParse(value)?.hasAbsolutePath != true) {
                            return 'URL invalide';
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: _saveUrls,
                icon: const Icon(Icons.save),
                label: const Text("Enregistrer"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamer Dating App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

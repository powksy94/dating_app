import 'package:flutter/material.dart';
import 'roads.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';
import 'services/api_service.dart';
import 'services/notification_service.dart';
import 'services/unread_service.dart';

class App extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const App({super.key, required this.navigatorKey});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    NotificationService.init(widget.navigatorKey);
    UnreadService.refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _obscured = state == AppLifecycleState.inactive ||
                 state == AppLifecycleState.paused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nocturne',
      debugShowCheckedModeBanner: false,
      navigatorKey: widget.navigatorKey,
      theme: _nocturneTheme(),
      onGenerateRoute: Routes.generateRoute,
      builder: (context, child) => Stack(
        children: [
          child!,
          if (_obscured)
            Positioned.fill(
              child: Container(
                color: const Color(0xFF0D0010),
                child: const SafeArea(
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/icons/app_icon.png'),
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      home: FutureBuilder<String?>(
        future: ApiService.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data != null ? const HomePage() : const LoginPage();
        },
      ),
    );
  }

  ThemeData _nocturneTheme() {
    const Color bgDark        = Color(0xFF0D0009);
    const Color surface       = Color(0xFF1A0A1F);
    const Color primary       = Color(0xFF7B00D4);
    const Color secondary     = Color(0xFF8B0000);
    const Color textPrimary   = Color(0xFFE8E0EE);
    const Color textSecondary = Color(0xFFAA9AB5);

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme.dark(
        surface:   surface,
        primary:   primary,
        secondary: secondary,
        onPrimary: Colors.white,
        onSurface: textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF120018),
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color:       textPrimary,
          fontSize:    20,
          fontWeight:  FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        labelStyle: const TextStyle(color: textPrimary, fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: primary, width: 0.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge:  TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textSecondary),
      ),
    );
  }
}

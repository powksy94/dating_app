import 'dart:io';

class AppHttpOverrides extends HttpOverrides {
  final String userAgent;
  AppHttpOverrides(this.userAgent);

  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)..userAgent = userAgent;
}

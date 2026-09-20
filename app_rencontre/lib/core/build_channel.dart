/// True for a release build compiled for internal or closed testing, rather
/// than the public production release. Sent once, at registration, so the
/// backend can keep test accounts out of the real discovery pool and vice
/// versa (see auth.controller.ts `register`).
///
/// Set at build time, defaults to false so a plain `flutter build appbundle`
/// (no flag) is always treated as a production build:
///   flutter build appbundle --release --dart-define=TEST_BUILD=true
const bool kTestBuild = bool.fromEnvironment('TEST_BUILD');

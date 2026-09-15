# Nocturne

Flutter dating app for the alternative and goth community: swipe-based
discovery, elegies (a sincere first-message ritual instead of a plain like),
real-time chat, events, and subscription plans (Ombre/Nocturne/Abyssal).

## Getting started

1. `flutter pub get`
2. `flutter run`

By default this talks to the production API. To point the app at a local
backend instead, see "Backend URL" below.

## Project structure

Code is organized by feature domain under `lib/domains/`, each with its own
`views/`, `widgets/`, `services/`, and `models/` as needed:

```
admin  auth  chat  discovery  elegie  event  home  match  profile  settings  social  subscription  visit
```

Cross-cutting code (API client, shared widgets/utils not tied to one domain)
lives under `lib/shared/`.

## Backend URL

`lib/shared/services/api_service.dart` decides which backend the app talks
to:

- **Release builds** always point at the deployed production backend, with
  no exception.
- **Debug (`flutter run`)** defaults to `10.0.2.2` (the Android emulator's
  address for the host machine) or `localhost` (iOS Simulator), so it can
  reach a backend running locally on the same machine.
- To test from a **real phone** on the same network as your dev machine,
  pass your machine's local IP explicitly:

  ```
  flutter run --dart-define=API_BASE_URL=http://<your-local-ip>:3000/api
  ```

## Localization

Strings live in `lib/l10n/app_fr.arb` and `lib/l10n/app_en.arb`. After
editing either file, regenerate the generated Dart localization classes:

```
flutter gen-l10n
```

## Building a release

```
flutter build appbundle --release   # Play Store
flutter build apk --release         # standalone APK
```

Bump `version` in `pubspec.yaml` (the part after `+` is the Android
`versionCode` and must increase on every Play Store upload).

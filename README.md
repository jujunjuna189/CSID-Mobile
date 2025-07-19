# CSID Mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Flutter version

- flutter stable 3.24.3
- Android min target 8 (oreo)
- Ios min target 13.0

## Run flutter with environment

Run with production

```
flutter run --dart-define-from-file=.env
```

Run with development

```
flutter run --dart-define-from-file=.env_dev
```

Run with staging

```
flutter run --dart-define-from-file=.env_staging
```

Run build with production

```
flutter build apk --dart-define-from-file=.env
flutter build appbundle --dart-define-from-file=.env
```

Run build with development

```
flutter build apk --dart-define-from-file=.env_dev
flutter build appbundle --dart-define-from-file=.env_dev
```

Run build with staging

```
flutter build apk --dart-define-from-file=.env_staging
flutter build appbundle --dart-define-from-file=.env_staging
```

Run release with prod

```
flutter build ipa --release --dart-define-from-file=.env
```

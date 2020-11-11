# [![Flutter logo][]][flutter.dev]

A Flutter mobile app to emulate iOS Translator with Routes, Singleton pattern, Bloc pattern, Push Notifications (Firebase), Shared Preferences, SQLite Relational Database, ChangeNotifier to manage the state, Maps, Security, and CI/CD with GitHub Actions.

## Scrum/Agile

![agile][]

## Flutter commnads

```
flutter doctor
```

```
flutter upgrade
```

```
flutter channel
```

```
flutter create translator
```

```
flutter pub get
```

```
flutter run --debug
flutter run --release
```

```
flutter run --trace-startup --profile

```

```
flutter pub get
flutter pub run flutter_launcher_icons:main
```

A unit test tests a single function, method, or class.
A widget test (in other UI frameworks referred to as component test) tests a single widget.
An integration test tests a complete app or a large part of an app.

```
flutter test
```

```
flutter clean
```

```
flutter build apk
```

```
flutter build appbundle
```
## GitHub Actions

```
name: Flutter Test & Deploy

on:
  schedule:
    - cron: "0 0 1 * *"

  workflow_dispatch:

  push:
    branches:
      - main
      - develop
      - security
  pull_request:
    branches:
      - main
      - develop
      - security

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/setup-java@v1
        with:
          java-version: "12.x"
      - uses: subosito/flutter-action@v1
        with:
          channel: "stable"
      - name: Upgrade Flutter
        run: flutter pub upgrade
      - name: Install dependencies
        run: flutter pub get
      - name: Flutter test
        run: flutter test
      - name: Flutter build
        run: flutter build apk
      - name: Create a Release APK
        uses: actions/upload-artifact@v2
        with:
          name: Files APK Generated
          path: "build/app/outputs/apk/release/*.apk"
```

## Branches

![branches][]

## Security

```
*SECURITY* (check out security branch on this project)
- [x] Create a new branch named security 
- [x] Do not allow Jailbreak 
- [x] Do not allow access as a ROOT
- [x] Obfuscating-Dart-Code 

```

## Mapbox

Go to MabBox to generate the TOKEN and Create a folder inside of assets with the name config and inside config create a config.json (have a look to the class map_views.dart)

```
{
"mapbox_api_token": "YOUR TOKEN HERE"
}
```

## e2517

![flutter][]
![map][]

## Push Notifications Data

![develop][]

## GitHub Actions (CI/CD): Testing and Release APK for Android

![github][]

[flutter logo]: https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-lockup.png
[flutter.dev]: https://flutter.dev
[dart platform diagram]: https://github.com/flutter/website/blob/master/src/images/homepage/dart-diagram-small.png
[flutter]: https://github.com/E2517/images/blob/main/images/translator/translator.png
[map]: https://github.com/E2517/images/blob/main/images/translator/mapboxgithub.png
[github]: https://github.com/E2517/images/blob/main/images/translator/githubactions.png
[develop]: https://github.com/E2517/images/blob/main/images/translator/develop.png
[branches]: https://github.com/E2517/images/blob/main/images/translator/branches.png
[agile]: https://github.com/E2517/images/blob/main/images/translator/agile.png

- Upgrade the minimum SDK Version to 20 in Android and iOS to use MapBox

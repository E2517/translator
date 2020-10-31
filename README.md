# [![Flutter logo][]][flutter.dev]

A Flutter mobile app to emulate iOS Translator with Routes, Singleton pattern,  Bloc pattern, Push Notifications (Firebase), Shared Preferences, SQLite Relational Database (develop branch), ChangeNotifier to manage the state, Maps and CI/CD with GitHub Actions.

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
[map]:https://github.com/E2517/images/blob/main/images/translator/mapboxgithub.png
[github]: https://github.com/E2517/images/blob/main/images/translator/githubactions.png
[develop]: https://github.com/E2517/images/blob/main/images/translator/develop.png

- Upgrade the minimum SDK Version to 20 in Android and iOS to use MapBox

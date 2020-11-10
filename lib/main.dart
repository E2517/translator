import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:provider/provider.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/firebase/push_notifications_firebase.dart';
import 'package:translator/preferences/shared_preferences.dart';
import 'package:translator/views/favourites_views.dart';
import 'package:translator/views/map_views.dart';
import 'package:translator/views/translator_views.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SQLiteDatabase.db),
    ], child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pushNotifications = new PushNotifications();
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  bool _jailbroken;
  bool _developerMode;

  Future<void> initPlatformStateJailBreak() async {
    bool jailbroken;
    bool developerMode;
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
      _developerMode = developerMode;
    });

    if (_jailbroken || _developerMode) exit(77);
  }

  @override
  void initState() {
    super.initState();
    initPlatformStateJailBreak();
    SharedPref.init();

    setState(() {
      _pushNotifications.initNotifications();
      _pushNotifications.messages.listen((data) {
        navigatorKey.currentState.pushNamed('map', arguments: data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Translate',
      theme: ThemeData.dark(),
      initialRoute: 'translator',
      routes: {
        'translator': (BuildContext context) => Translator(),
        'favourites': (BuildContext context) => Favourites(),
        'map': (BuildContext context) => MapBox(),
      },
      onUnknownRoute: (RouteSettings settings) {
        print('Not founded route: ${settings.name}');
        return MaterialPageRoute(builder: (context) => Translator());
      },
    );
  }
}

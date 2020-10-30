import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/firebase/push_notifications_firebase.dart';
import 'package:translator/models/translate_models.dart';
import 'package:translator/preferences/shared_preferences.dart';
import 'package:translator/views/favourites_views.dart';
import 'package:translator/views/map_views.dart';
import 'package:translator/views/translator_views.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pushNotifications = new PushNotifications();
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    SharedPref.init();

    setState(() {
      _pushNotifications.initNotifications();
      _pushNotifications.messages.listen((data) {
        SharedPref().saveFirebaseData(data);
        navigatorKey.currentState.pushNamed('map', arguments: data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TranslateModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Translate',
        theme: ThemeData.dark(),
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => Translator(),
          'favourites': (BuildContext context) => Favourites(),
          'map': (BuildContext context) => Map(),
        },
        onUnknownRoute: (RouteSettings settings) {
          print('Not founded route: ${settings.name}');
          return MaterialPageRoute(builder: (context) => Translator());
        },
      ),
    );
  }
}

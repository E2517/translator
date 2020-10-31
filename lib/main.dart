import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/firebase/push_notifications_firebase.dart';
import 'package:translator/models/languajes_models.dart';
// import 'package:translator/database/sqlite_database.dart';
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
        print('Push Notifications data: ${data[0]} ${data[1]} ${data[2]}');
        final lang = Languages(
            id: int.tryParse(data[0]), english: data[1], spanish: data[2]);

        SQLiteDatabase.db.insertLanguagesByRaw(lang);

        SharedPref().saveFirebaseData(data[1]);
        navigatorKey.currentState.pushNamed('map', arguments: data);
      });
    });
  }

  void checkDatabase() async {
    // print('Data ${await SQLiteDatabase.db.getAllLanguages()}');
    // SQLiteDatabase.db.deleteAll();
    // print(await SQLiteDatabase.db.getLanguageByIndex('english', 0));
  }

  @override
  Widget build(BuildContext context) {
    checkDatabase();
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
          'map': (BuildContext context) => MapBox(),
        },
        onUnknownRoute: (RouteSettings settings) {
          print('Not founded route: ${settings.name}');
          return MaterialPageRoute(builder: (context) => Translator());
        },
      ),
    );
  }
}

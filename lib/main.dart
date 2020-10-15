import 'package:flutter/material.dart';
import 'package:translator/views/translator_views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Translator',
      theme: ThemeData.dark(),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => Translator(),
      },
      onUnknownRoute: (RouteSettings settings) {
        print('Not founded route: ${settings.name}');
        return MaterialPageRoute(builder: (context) => Translator());
      },
    );
  }
}

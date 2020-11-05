import 'package:flutter/material.dart';
import 'package:translator/preferences/shared_preferences.dart';
import 'package:translator/utils/alert_cupertino_utils.dart' as utils;
import 'package:translator/widgets/translator/body_translator_widgets.dart';
import 'package:translator/widgets/bottom_widgets.dart';
import 'package:translator/widgets/translator/header_translator_widget.dart';

class Translator extends StatefulWidget {
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  @override
  Widget build(BuildContext context) {
    Future<Null> _refresh() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        HeaderTranslator();
        BodyTranslator();
      });
    }

    return Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            children: [HeaderTranslator(), BodyTranslator()],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 75.0),
          child: FloatingActionButton(
            backgroundColor: Color.fromRGBO(106, 197, 220, 1),
            child: Icon(
              Icons.mic,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'favourites');
            },
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('translator', (route) => false);
              } else if (index == 1) {
                showDialog(
                    context: context, child: utils.CustomAlertCupertino());

                _refresh();
              } else if (index == 2) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'favourites', (route) => true,
                    arguments: SharedPref().getFirebaseData('firebase'));
              }
            });
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:translator/preferences/shared_preferences.dart';
import 'package:translator/utils/bottom_utils.dart';

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
        ViewTranslator();
      });
    }

    return Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ViewTranslator(),
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
              SharedPref().removeFirebaseData('firebase');
              _refresh();
            },
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (route) => false);
              } else if (index == 1) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'favourites', (route) => true,
                    arguments: SharedPref().getFirebaseData('firebase'));
              }
            });
          },
        ));
  }
}

class ViewTranslator extends StatelessWidget {
  const ViewTranslator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, top: 15.0, right: 5.0, bottom: 15.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(28, 28, 30, 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('Spanish',
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center),
                      )),
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, top: 15.0, right: 15.0, bottom: 15.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(28, 28, 30, 0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: [
                          Text(
                            'English',
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'UK',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      )),
                ))
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(28, 28, 30, 0.5),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FutureBuilder(
                    future: SharedPref().getFirebaseData('firebase'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return TextField(
                          style: TextStyle(fontSize: 24.0),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: snapshot.hasData
                                  ? snapshot.data
                                  : 'Enter text'),
                        );
                      }
                    })),
          ),
        )
      ],
    );
  }
}

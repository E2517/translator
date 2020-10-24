import 'package:flutter/material.dart';
import 'package:translator/preferences/shared_preferences.dart';

class BodyTranslator extends StatelessWidget {
  BodyTranslator({Key key}) : super(key: key);
  Widget build(BuildContext context) {
    return Expanded(
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
                          hintText: snapshot.data ?? 'Enter text'),
                    );
                  }
                })),
      ),
    );
  }
}

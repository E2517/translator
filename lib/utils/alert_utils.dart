import 'package:flutter/material.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/preferences/shared_preferences.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          backgroundColor: Color.fromRGBO(106, 197, 220, 1),
          content: Text(message,
              style: TextStyle(fontSize: 18.0), textAlign: TextAlign.start),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () {
                SharedPref().removeFirebaseData('firebase');
                Navigator.of(context).pop();
              },
              onLongPress: () {
                SQLiteDatabase.db.deleteAll();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

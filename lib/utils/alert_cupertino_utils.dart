import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/preferences/shared_preferences.dart';

class CustomAlertCupertino extends StatefulWidget {
  CustomAlertCupertino(
      {Key key,
      this.title,
      this.description,
      this.actionCancel,
      this.actionDeleteEdit,
      this.onPressedCancel,
      this.onPressedDeleteEdit})
      : super();

  final String title;
  final String description;
  final String actionCancel;
  final String actionDeleteEdit;
  final Function onPressedCancel;
  final Function onPressedDeleteEdit;

  @override
  _CustomAlertCupertinoState createState() => _CustomAlertCupertinoState(
      title,
      description,
      actionCancel,
      actionDeleteEdit,
      onPressedCancel,
      onPressedDeleteEdit);
}

class _CustomAlertCupertinoState extends State<CustomAlertCupertino> {
  String title;
  String description;
  String actionCancel;
  String actionDeleteEdit;
  Function onPressedCancel;
  Function onPressedDeleteEdit;
  _CustomAlertCupertinoState(this.title, this.description, this.actionCancel,
      this.actionDeleteEdit, this.onPressedCancel, this.onPressedDeleteEdit);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title ?? 'Translator',
        style: TextStyle(fontSize: 24.0),
      ),
      content: Text(description ?? 'Are you sure you want to delete all data?',
          style: TextStyle(fontSize: 18.0)),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPressedCancel ??
                () async {
                  Navigator.of(context).pop();
                },
            child: Text(actionCancel ?? 'Cancel')),
        CupertinoDialogAction(
            textStyle: TextStyle(fontSize: 18.0, color: Colors.red),
            isDefaultAction: true,
            onPressed: onPressedDeleteEdit ??
                () async {
                  await SharedPref().removeFirebaseData('firebase');
                  await SQLiteDatabase.db.deleteAll();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('translator', (route) => true);
                },
            child: Text(actionDeleteEdit ?? 'Delete')),
      ],
    );
  }
}

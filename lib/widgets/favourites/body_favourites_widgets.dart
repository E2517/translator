import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/utils/alert_cupertino_utils.dart';

class BodyFavourites extends StatefulWidget {
  const BodyFavourites({Key key}) : super(key: key);

  @override
  _BodyFavouritesState createState() => _BodyFavouritesState();
}

class _BodyFavouritesState extends State<BodyFavourites> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'English - Spanish',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: FutureBuilder(
              future: SQLiteDatabase.db.getAllLanguages(),
              builder: (context, snapshot) {
                List<Languages> data = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Languages lang = data[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Dismissible(
                        background: slideRightBackground(),
                        secondaryBackground: slideLeftBackground(),
                        key: Key(lang.toString()),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            final bool res = await showDialog(
                                context: context,
                                child: CustomAlertCupertino(
                                  title: 'Favourites',
                                  description:
                                      'Are you sure you want to remove this widget and delete it from the database?',
                                  onPressedCancel: () async {
                                    Navigator.of(context).pop();
                                  },
                                  actionCancel: 'Cancel',
                                  onPressedDeleteEdit: () async {
                                    await SQLiteDatabase.db
                                        .deleteLanguage(lang.id);
                                    data.removeAt(index);
                                    Navigator.of(context).pop();
                                  },
                                  actionDeleteEdit: 'Delete',
                                ));

                            return res;
                          } else {
                            final bool res = await showDialog(
                                context: context,
                                child: CustomAlertCupertino(
                                  title: 'Favourites',
                                  description:
                                      'Are you sure you want to edit this widget and update the database?',
                                  onPressedCancel: () async {
                                    Navigator.of(context).pop();
                                  },
                                  actionCancel: 'Cancel',
                                  onPressedDeleteEdit: () async {
                                    await SQLiteDatabase.db.updateLanguages(
                                        Languages(
                                            id: 1,
                                            english: 'Hello',
                                            spanish: 'Hola'));
                                    data.removeAt(index);
                                    Navigator.of(context).pop();
                                  },
                                  actionDeleteEdit: 'Edit',
                                ));

                            return res;
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(28, 28, 30, 0.5),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0,
                                top: 15.0,
                                right: 15.0,
                                bottom: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'English(UK)',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Color.fromRGBO(106, 197, 220, 1)),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  lang.english,
                                  style: TextStyle(fontSize: 24.0),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'Spanish',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Color.fromRGBO(106, 197, 220, 1)),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  lang.spanish,
                                  style: TextStyle(fontSize: 24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Color.fromRGBO(106, 197, 220, 1),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

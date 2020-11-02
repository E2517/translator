import 'package:flutter/material.dart';
import 'package:translator/database/sqlite_database.dart';

class BodyFavourites extends StatelessWidget {
  const BodyFavourites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(28, 28, 30, 0.5),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, top: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'English(UK)',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Color.fromRGBO(106, 197, 220, 1)),
                          ),
                          SizedBox(height: 10.0),
                          FutureBuilder(
                            future: SQLiteDatabase.db.getAllLanguages(),
                            builder: (context, snapshot) {
                              List<Languages> data = snapshot.data ?? [];
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  Languages lang = data[index];
                                  return Text(
                                    lang.english,
                                    style: TextStyle(fontSize: 30.0),
                                  );
                                },
                              );
                            },
                          )
                        ]),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, top: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spanish',
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Color.fromRGBO(106, 197, 220, 1)),
                          ),
                          SizedBox(height: 10.0),
                          FutureBuilder(
                            future: SQLiteDatabase.db.getAllLanguages(),
                            builder: (context, snapshot) {
                              List<Languages> data = snapshot.data ?? [];
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  Languages lang = data[index];
                                  return Text(
                                    lang.spanish,
                                    style: TextStyle(fontSize: 30.0),
                                  );
                                },
                              );
                            },
                          )
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BodyFavourites extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const BodyFavourites({Key key, @required this.snapshot}) : super(key: key);

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
                          Text(
                            snapshot.data,
                            style: TextStyle(fontSize: 30.0),
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
                            style: TextStyle(fontSize: 24.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Google Translate API',
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Color.fromRGBO(106, 197, 220, 1)),
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

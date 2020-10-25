import 'package:flutter/material.dart';

class HeaderTranslator extends StatelessWidget {
  const HeaderTranslator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  )),
            )),
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
          ],
        ),
      ),
    );
  }
}

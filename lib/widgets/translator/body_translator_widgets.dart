import 'package:flutter/material.dart';

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
          child: TextField(
            style: TextStyle(fontSize: 24.0),
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter text'),
          ),
        ),
      ),
    );
  }
}

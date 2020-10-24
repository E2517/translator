import 'dart:async';

import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, 'home'));
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: dataPushNotifications != null
              ? Text(
                  '$dataPushNotifications',
                  style: TextStyle(fontSize: 24.0),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

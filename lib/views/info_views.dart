import 'dart:async';

import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    Timer(Duration(seconds: 10),
        () => Navigator.pushReplacementNamed(context, 'home'));
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                leading: Image(image: AssetImage('assets/images/icon.png')),
                title: Text(
                  'Full Stack Developer',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'everis an NTT Data Company',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.laptop,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('home', (route) => false);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: dataPushNotifications != null
                  ? Center(
                      child: Text(
                          'You have a new notification: $dataPushNotifications',
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}

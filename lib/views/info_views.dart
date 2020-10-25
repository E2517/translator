// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  MapboxMapController controller;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    // Timer(Duration(seconds: 10),
    //     () => Navigator.pushReplacementNamed(context, 'home'));
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
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/skater.jpg'),
                ),
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
                  : Center(
                      child: MapboxMap(
                        accessToken:
                            'pk.eyJ1IjoiY29uZ29tYXAiLCJhIjoiY2tnb3dzeGNyMGduNzJ6bW4yOXVuZTk2ZyJ9.AjUBf6jX3xmPqdF6ZO5qxQ',
                        onMapCreated: _onMapCreated,
                        styleString:
                            'mapbox://styles/congomap/ckgowxofl1vbq19odmykhkzhs',
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(51.50853, -0.12574),
                          zoom: 10.0,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:translator/widgets/Map/header_map_widget.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  MapboxMapController controller;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    Timer(Duration(seconds: 15),
        () => Navigator.pushReplacementNamed(context, 'home'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            }),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
          IconButton(icon: Icon(Icons.remove), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          Expanded(
            child: Container(
              child: dataPushNotifications != null
                  ? HeaderInfo(text: dataPushNotifications)
                  : MapboxMap(
                      accessToken:
                          'pk.eyJ1IjoiY29uZ29tYXAiLCJhIjoiY2tnb3dzeGNyMGduNzJ6bW4yOXVuZTk2ZyJ9.AjUBf6jX3xmPqdF6ZO5qxQ',
                      onMapCreated: _onMapCreated,
                      styleString:
                          'mapbox://styles/congomap/ckgoy5ok80l6s1apmpcdqiy9n',
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(51.50853, -0.12574),
                        zoom: 11.0,
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: FloatingActionButton(
          backgroundColor: Color.fromRGBO(106, 197, 220, 1),
          child: Icon(Icons.person_pin),
          onPressed: () {},
        ),
      ),
    );
  }
}

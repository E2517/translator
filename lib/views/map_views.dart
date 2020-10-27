import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:translator/preferences/shared_preferences.dart';
import 'package:translator/widgets/Map/header_map_widget.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  String selectedStyle = 'mapbox://styles/congomap/ckgoy5ok80l6s1apmpcdqiy9n';
  final dark = 'mapbox://styles/congomap/ckgoy5ok80l6s1apmpcdqiy9n';
  final clear = 'mapbox://styles/congomap/ckgrq1yf30dvd19p7eimi7a1z';
  MapboxMapController controller;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
  }

  void _onStyleLoaded() {
    addImageFromAssets("carlos", "assets/images/skater.png");
  }

  Future<void> addImageFromAssets(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  @override
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    if (dataPushNotifications != null) {
      Timer(Duration(seconds: 10),
          () => Navigator.pushReplacementNamed(context, 'map'));
    }

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
          IconButton(
            icon: Icon(Icons.cloud_circle_sharp,
                color: Color.fromRGBO(106, 197, 220, 1)),
            onPressed: () {
              setState(() {
                if (selectedStyle == dark) {
                  selectedStyle = clear;
                } else {
                  selectedStyle = dark;
                }
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.add, color: Color.fromRGBO(106, 197, 220, 1)),
              onPressed: () {
                controller.moveCamera(CameraUpdate.zoomIn());
              }),
          IconButton(
              icon: Icon(Icons.remove, color: Color.fromRGBO(106, 197, 220, 1)),
              onPressed: () {
                controller.moveCamera(CameraUpdate.zoomOut());
              }),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: dataPushNotifications != null
                ? HeaderInfo(text: dataPushNotifications)
                : MapboxMap(
                    accessToken:
                        'pk.eyJ1IjoiY29uZ29tYXAiLCJhIjoiY2tnb3dzeGNyMGduNzJ6bW4yOXVuZTk2ZyJ9.AjUBf6jX3xmPqdF6ZO5qxQ',
                    onMapCreated: _onMapCreated,
                    onStyleLoadedCallback: _onStyleLoaded,
                    styleString: selectedStyle,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(51.50853, -0.12574),
                      zoom: 11.0,
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FutureBuilder(
              future: SharedPref().getFirebaseData('firebase'),
              builder: (context, snapshot) {
                return FloatingActionButton(
                  backgroundColor: Color.fromRGBO(106, 197, 220, 1),
                  child: Icon(Icons.person_pin),
                  onPressed: () {
                    controller.addSymbol(
                      SymbolOptions(
                          geometry: LatLng(51.515419, -0.141099),
                          iconSize: 0.4,
                          iconImage: 'carlos',
                          textField: snapshot.data,
                          textColor: '#6AC5DC',
                          textMaxWidth: 50.0,
                          textOffset: Offset(0, 3)),
                    );
                  },
                );
              })),
    );
  }
}

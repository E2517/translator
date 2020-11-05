import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:translator/preferences/shared_preferences.dart';
import 'package:translator/widgets/Map/header_map_widgets.dart';

class MapBox extends StatefulWidget {
  @override
  _MapBoxState createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  String selectedStyle = 'mapbox://styles/congomap/ckgoy5ok80l6s1apmpcdqiy9n';
  final dark = 'mapbox://styles/congomap/ckgoy5ok80l6s1apmpcdqiy9n';
  final blue = 'mapbox://styles/congomap/ckgs5h9mr01qb19o0jgztrbhm';

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

  Future<Map<String, dynamic>> _loadConfigFile() async {
    String jsonString =
        await rootBundle.loadString('assets/config/config.json');
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    final dataPushNotifications = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, 'translator');
            }),
      ),
      body: Stack(
        children: [
          Container(
            child: dataPushNotifications != null
                ? HeaderInfo()
                : FutureBuilder(
                    future: _loadConfigFile(),
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return MapboxMap(
                        accessToken:
                            snapshot.data['mapbox_api_token'] as String,
                        onMapCreated: _onMapCreated,
                        onStyleLoadedCallback: _onStyleLoaded,
                        styleString: selectedStyle,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(51.50853, -0.12574),
                          zoom: 11.0,
                        ),
                      );
                    },
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.cloud_circle_sharp,
                        size: 30.0, color: Color.fromRGBO(106, 197, 220, 1)),
                    onPressed: () {
                      setState(() {
                        if (selectedStyle == dark) {
                          selectedStyle = blue;
                        } else {
                          selectedStyle = dark;
                        }
                      });
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.add,
                          size: 30.0, color: Color.fromRGBO(106, 197, 220, 1)),
                      onPressed: () {
                        controller.moveCamera(CameraUpdate.zoomIn());
                      }),
                  IconButton(
                      icon: Icon(Icons.remove,
                          size: 30.0, color: Color.fromRGBO(106, 197, 220, 1)),
                      onPressed: () {
                        controller.moveCamera(CameraUpdate.zoomOut());
                      }),
                ],
              ),
            ],
          )
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

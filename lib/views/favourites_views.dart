import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/database/sqlite_database.dart';
import 'package:translator/models/translate_models.dart';
import 'package:translator/widgets/bottom_widgets.dart';
import 'package:translator/widgets/favourites/body_favourites_widgets.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  SQLiteDatabase db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favourites'),
          centerTitle: true,
        ),
        body: Consumer<TranslateModel>(
          builder: (context, translate, child) {
            return FutureBuilder(
              future: translate.dataFirebase,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rate,
                        size: 75,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 35.0),
                      Text('No Favourites',
                          style: TextStyle(fontSize: 24.0, color: Colors.grey)),
                      SizedBox(height: 20.0),
                      Text('Your favourite translation will apperar here',
                          style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                    ],
                  ));
                }

                return BodyFavourites(
                  db: db,
                );
              },
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 2,
          labelTwo: 'Map',
          iconTwo: Icon(Icons.zoom_out_map_sharp),
          labelThree: 'Favourites',
          iconThree: Icon(Icons.star_rate),
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (route) => false);
              } else if (index == 1) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('map', (route) => false);
              } else if (index == 2) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('favourites', (route) => false);
              }
            });
          },
        ));
  }
}

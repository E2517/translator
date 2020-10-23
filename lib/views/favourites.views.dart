import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/models/translate_models.dart';
import 'package:translator/widgets/bottom_widgets.dart';
import 'package:translator/widgets/favourites/body_favourites.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context).settings.arguments;

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
                      Text('Your Favourite translation will apperar here',
                          style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                    ],
                  ));
                }

                return Body(
                  snapshot: snapshot,
                );
              },
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (route) => false);
              }
            });
          },
        ));
  }
}

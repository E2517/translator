import 'package:flutter/material.dart';
import 'package:translator/utils/bottom_utils.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Favourites'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Text(snapshot.data);
              },
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('home', (route) => false);
              } else if (index == 1) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('favourites', (route) => true);
              }
            });
          },
        ));
  }
}

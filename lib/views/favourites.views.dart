import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  int indexPressed = 1;
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
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color.fromRGBO(106, 197, 220, 1),
        currentIndex: indexPressed,
        items: [
          BottomNavigationBarItem(
              label: 'Translate', icon: Icon(Icons.g_translate)),
          BottomNavigationBarItem(
              label: 'Favourite', icon: Icon(Icons.star_rate)),
        ],
        onTap: (index) {
          indexPressed = index;
          setState(() {
            if (index == 0) {
              Navigator.pushNamed(context, 'home');
            }
          });
        },
      ),
    );
  }
}

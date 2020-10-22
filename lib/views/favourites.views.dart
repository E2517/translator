import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/models/translate_models.dart';
import 'package:translator/widgets/bottom_widgets.dart';

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
                  return Center(child: CircularProgressIndicator());
                }
                return Center(child: Text(snapshot.data));
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

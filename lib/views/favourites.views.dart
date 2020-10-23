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
        body: SingleChildScrollView(
          child: Consumer<TranslateModel>(
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
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.grey)),
                        SizedBox(height: 20.0),
                        Text('Your Favourite translation will apperar here',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey)),
                      ],
                    ));
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Spanish - English',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(28, 28, 30, 0.5),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0,
                                    top: 15.0,
                                    right: 15.0,
                                    bottom: 15.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Spanish',
                                        style: TextStyle(fontSize: 24.0),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data,
                                        style: TextStyle(fontSize: 30.0),
                                      )
                                    ]),
                              ),
                              SizedBox(height: 25.0),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0,
                                    top: 15.0,
                                    right: 15.0,
                                    bottom: 15.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'English(UK)',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: Color.fromRGBO(
                                                106, 197, 220, 1)),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        snapshot.data,
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Color.fromRGBO(
                                                106, 197, 220, 1)),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
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

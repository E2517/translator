import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends BottomNavigationBar {
  CustomBottomNavigationBar(
      {Key key, int currentIndex, Function(int index) onTap})
      : super(
            key: key,
            fixedColor: Color.fromRGBO(106, 197, 220, 1),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  label: 'Translate', icon: Icon(Icons.g_translate)),
              BottomNavigationBarItem(
                  label: 'Favourites', icon: Icon(Icons.star_rate)),
            ],
            onTap: onTap);
}

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends BottomNavigationBar {
  CustomBottomNavigationBar(
      {Key key,
      int currentIndex,
      String labelOne,
      String labelTwo,
      Function(int index) onTap})
      : super(
            key: key,
            fixedColor: Color.fromRGBO(106, 197, 220, 1),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  label: labelOne ?? 'Translate',
                  icon: Icon(Icons.g_translate)),
              BottomNavigationBarItem(
                  label: 'Remove', icon: Icon(Icons.delete_outline)),
              BottomNavigationBarItem(
                  label: labelTwo ?? 'Favourites', icon: Icon(Icons.star_rate)),
            ],
            onTap: onTap);
}

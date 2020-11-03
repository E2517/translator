import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends BottomNavigationBar {
  CustomBottomNavigationBar(
      {Key key,
      @required int currentIndex,
      String labelOne,
      String labelTwo,
      String labelThree,
      Icon iconOne,
      Icon iconTwo,
      Icon iconThree,
      @required Function(int index) onTap})
      : super(
            key: key,
            fixedColor: Color.fromRGBO(106, 197, 220, 1),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  label: labelOne ?? 'Translate',
                  icon: Icon(Icons.g_translate)),
              BottomNavigationBarItem(
                  label: labelTwo ?? 'Remove',
                  icon: iconTwo ?? Icon(Icons.delete_outline)),
              BottomNavigationBarItem(
                  label: labelThree ?? 'Favourites',
                  icon: iconThree ?? Icon(Icons.star_rate)),
            ],
            onTap: onTap);
}

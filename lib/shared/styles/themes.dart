import 'package:flutter/material.dart';

class MyThemeData {
  static const Color primaryColor = Color.fromRGBO(93, 156, 236, 1.0);
  static const Color doneColor = Color.fromRGBO(97, 231, 87, 1.0);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(223, 236, 219, 1),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      elevation: 6,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      selectedIconTheme: IconThemeData(size: 35),
      unselectedIconTheme: IconThemeData(size: 25),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color.fromRGBO(255, 255, 255, 1.0),
      elevation: 0,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(6, 14, 30, 1.0),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      elevation: 6,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Color.fromRGBO(20, 25, 34, 1.0),
      selectedIconTheme: IconThemeData(size: 35),
      unselectedIconTheme: IconThemeData(size: 25, color: Colors.white),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color.fromRGBO(20, 25, 34, 1.0),
      elevation: 0,
    ),
  );
}

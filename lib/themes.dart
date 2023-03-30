import 'package:flutter/material.dart';

class ThemeClass {
  Color primaryColor = Colors.blue;
  Color secondaryColor = Color.fromARGB(255, 149, 117, 205);
  Color darkPrimaryColor = Colors.blue.shade900;
  Color darkSecondaryColor = Colors.purple.shade900;
  Color tertiaryColor = Colors.blue.shade300;
  Color offWhite = Color.fromARGB(255, 245, 245, 245);

  static ThemeData lightTheme = ThemeData(
      fontFamily: 'Neon',
      //---------------------------------Switches
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all<Color>(Colors.white),
          thumbColor:
              MaterialStateProperty.all<Color>(_themeClass.tertiaryColor)),
      //------------------------------------------Text theme
      textTheme: TextTheme(
          titleMedium: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
      //-----------------Cards
      cardTheme: CardTheme(
          color: _themeClass.offWhite, shadowColor: _themeClass.primaryColor),
      //---------------------bottomAppBar
      bottomAppBarTheme: BottomAppBarTheme(
        color: _themeClass.primaryColor,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
      ),
      //--------------------------------------------button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        splashColor: _themeClass.primaryColor,
        foregroundColor: Colors.white,
        backgroundColor: _themeClass.primaryColor,
      ),
      //------------------drawers
      drawerTheme: DrawerThemeData(
        width: 250,
        backgroundColor: Colors.white70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      //--------------------------------------
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: _themeClass.primaryColor,
        secondary: _themeClass.secondaryColor,
        tertiary: _themeClass.tertiaryColor,
      ));

  static ThemeData darkTheme = ThemeData(
      fontFamily: 'Neon',
      //---------------------------------Switches
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all<Color>(Colors.grey),
          thumbColor:
              MaterialStateProperty.all<Color>(_themeClass.primaryColor)),
      //--------------------------------------Text
      textTheme: TextTheme(
          titleMedium: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      //--------------------------------------------button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        splashColor: _themeClass.primaryColor,
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey,
      ),
      //----------------------------------------------card
      //--------------------------Drawer theme
      drawerTheme: DrawerThemeData(
        elevation: 10,
        width: 250,
        backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _themeClass.darkPrimaryColor,
        secondary: _themeClass.darkSecondaryColor,
        tertiary: _themeClass.tertiaryColor,
      ));
}

ThemeClass _themeClass = ThemeClass();

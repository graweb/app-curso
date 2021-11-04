import 'package:flutter/material.dart' hide Route;

class Constantes {
  static String appName = "Fale Easy";

  //static String urlApi = "http://www.graweb.com.br/apieasyenglish/";
  static String urlApi = "http://192.168.0.62/apieasyenglish/";

  // CORES DO TEMA
  static Color lightPrimary = Color(0xfff3f3f3);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.lightBlue;
  static Color darkAccent = Colors.blueAccent;
  static Color lightBG = Color(0xfff3f3f3);
  static Color darkBG = Colors.black;
  static Color white = Colors.white;

  static Color azulApp = Color(0xff06518f);
  static Color verdeApp = Color(0xff9fde00);
  static Color begeApp = Color(0xffffdc73);
  static Color brancoApp = Color(0xffffffff);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

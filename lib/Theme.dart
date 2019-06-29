import 'package:flutter/material.dart';

class CustomThemes {
  static final ThemeData _template = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.light,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple[400],
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20
        )
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white
      )
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black54,
    ),
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.black87),
      subhead: TextStyle(color: Colors.black87)
    ),
    iconTheme: IconThemeData(
      color: Colors.black87
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    )
  );

  static final light = _template.copyWith(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.light
  );

  static final dark = _template.copyWith(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark
  );
}
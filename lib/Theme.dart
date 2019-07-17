import 'package:flutter/material.dart';

class CustomThemes {
  static final ThemeData _template = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      
      iconTheme: IconThemeData(
        color: Colors.black54,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black54,
          fontSize: 20
        )
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black54
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
      color: Colors.black54
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    )
  );

  static final light = _template.copyWith(
    brightness: Brightness.light,
  );
}
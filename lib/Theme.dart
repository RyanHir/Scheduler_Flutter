import 'package:flutter/material.dart';

class CustomThemes {
  static final ThemeData _template = ThemeData(
    primaryColor: Colors.purple,
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20
        )
      ),
      iconTheme: IconThemeData(
        color: Colors.white
      )
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white54
    )
  );

  static final light = _template.copyWith(
    brightness: Brightness.light,
  );

  static final dark = _template.copyWith(
    brightness: Brightness.dark,
  );

}
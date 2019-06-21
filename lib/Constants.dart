import 'package:flutter/material.dart';

class Constants {
  static const String title = "Plano Academy Scheduler";
  static const String settingsTitle = "Settings";
  static const String endpoint = "https://script.google.com/macros/s/AKfycbx6UM43jEELsS8VNJCQASpH60veCwJ2fESByIOgFqG8itpvK60v/exec";

  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    accentColor: Colors.blueAccent,
  );

  static const bool debug = true;

  static const IconData refreshIcon = Icons.refresh;
  static const IconData accountIcon = Icons.account_circle;
  static const IconData backIcon = Icons.arrow_back;

  static const List<int> grades = <int>[10,11,12];
  static const List<String> dataToIgnore = <String>["id",""];
}
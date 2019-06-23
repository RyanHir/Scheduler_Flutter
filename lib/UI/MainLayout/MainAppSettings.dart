import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/UI/Settings.dart';

class AppBarSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(Constants.settingsIcon),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        });
  }
}
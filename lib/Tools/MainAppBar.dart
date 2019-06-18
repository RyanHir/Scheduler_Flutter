import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Templates/GoogleAssets.dart';
import 'package:scheduler/Tools/GetSchedule.dart';
import 'package:scheduler/UI/Settings.dart';
import 'package:scheduler/UI/mainLayout.dart';

class AppBarSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(Icons.settings),
        onPressed: () {
          print("opening settings");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        });
  }
}

class AppBarRefresh extends StatelessWidget {
  final MainLayoutClass mainLayoutClass;

  AppBarRefresh(this.mainLayoutClass);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(Constants.refreshIcon),
      onPressed: () {
        mainLayoutClass.setState(() {
          mainLayoutClass.isLoading = true;
        });
        mainLayoutClass.refresh();
      });
  }
}

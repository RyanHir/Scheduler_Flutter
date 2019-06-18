import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/UI/MainLayout.dart';

class AppBarRefresh extends StatelessWidget {
  final MainLayoutClass mainLayoutClass;

  AppBarRefresh(this.mainLayoutClass);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(Constants.refreshIcon),
      onPressed: () {
        mainLayoutClass.mainLayoutProcessing.refresh();
      });
  }
}
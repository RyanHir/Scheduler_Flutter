import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Strings.dart';
import 'package:scheduler/UI/MainLayout.dart';
import 'package:scheduler/UI/Tabs/InfoTab/DrawInfoTab.dart';
import 'package:scheduler/UI/Tabs/GradeTab/DrawGradeTab.dart';
import 'package:scheduler/UI/Tabs/PersonalTab/DrawPersonalTab.dart';

class WidgetSelector extends StatelessWidget {
  final Tabs tab;
  final MainLayoutClass mainLayout;
  WidgetSelector(this.mainLayout, this.tab);

  Widget build(BuildContext context) {
    if (mainLayout.isLoading == false && mainLayout.isSignedIn == false) {
      return new Center(child:Text(Strings.pleaseSignIn));
    } else if (mainLayout.data == null) {
      return new Center(child: CircularProgressIndicator());
    } else {
      switch (tab) {
        case Tabs.personal:
          return new Container(
              padding: EdgeInsets.all(0), child: DrawPersonalTable(mainLayout.data["schedule"]));
        case Tabs.grade:
          return new Container(
              padding: EdgeInsets.all(0), child: DrawGradeList(mainLayout.data["table"]));
        case Tabs.info:
          return new Container(
              padding: EdgeInsets.all(0), child: ShowInfo(mainLayout.data["info"]));
        
      }
    }
    return null;
  }
}
import 'package:flutter/material.dart';
import 'package:scheduler/Strings.dart';
import 'package:scheduler/UI/MainLayout.dart';
import 'package:scheduler/UI/Tabs/InfoTab/DrawInfoTab.dart';
import 'package:scheduler/UI/Tabs/GradeTab/DrawGradeTab.dart';
import 'package:scheduler/UI/Tabs/PersonalTab/DrawPersonalTab.dart';

class WidgetSelector extends StatelessWidget {
  final String tab;
  final MainLayoutClass mainLayout;
  WidgetSelector(this.mainLayout, this.tab);

  Widget build(BuildContext context) {
    if (mainLayout.isLoading == false && mainLayout.isSignedIn == false) {
      return new Center(child:Text(Strings.pleaseSignIn));
    } else if (mainLayout.data == null) {
      return new Center(child: CircularProgressIndicator());
    } else if (mainLayout.isLoading == true) {
      return new Center(child: CircularProgressIndicator());
    } else {
      switch (tab) {
        case "personal":
          return new Container(
              padding: EdgeInsets.all(0), child: DrawPersonalTable(mainLayout.data["schedule"]));
        case "grade":
          return new Container(
              padding: EdgeInsets.all(0), child: DrawGradeList(mainLayout.data["table"]));
        case "info":
          return new Container(
              padding: EdgeInsets.all(0), child: ShowInfo(mainLayout.data["info"]));
        
      }
    }
    return null;
  }
}
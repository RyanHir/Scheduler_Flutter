import 'package:flutter/material.dart';
import 'package:scheduler/UI/InfoTab/DrawInfo.dart';
import 'package:scheduler/UI/DrawTable.dart';
import 'package:scheduler/UI/GradeTab/DrawGradeList.dart';

class ChooseCorrectWidget extends StatelessWidget {
  final data;
  final isLoading;
  final isLoggedIn;
  final tab;
  ChooseCorrectWidget(this.data, this.isLoading, this.isLoggedIn, this.tab);

  Widget build(BuildContext context) {
    if (isLoading == false && isLoggedIn == false) {
      return new Center(child:Text("Please Sign In Through The Settings"));
    } else if (data == null) {
      return new Center(child: CircularProgressIndicator());
    } else if (isLoading == true) {
      return new Center(child: CircularProgressIndicator());
    } else {
      switch (tab) {
        case "personal":
          return new Container(
              padding: EdgeInsets.all(0), child: DrawTable(data["schedule"]));
        case "grade":
          return new Container(
              padding: EdgeInsets.all(0), child: DrawGradeList(data["table"]));
        case "info":
          return new Container(
              padding: EdgeInsets.all(0), child: ShowInfo(data["info"]));
        
      }
    }
    return null;
  }
}
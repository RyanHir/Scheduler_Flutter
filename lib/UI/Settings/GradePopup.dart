
import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:scheduler/UI/Settings.dart';

class GradePopup extends StatefulWidget {
  final SettingsClass settingsMenu;

  GradePopup(this.settingsMenu);

  @override
  State<StatefulWidget> createState() {
    return new _GradePopupClass(settingsMenu);
  }
}

class _GradePopupClass extends State<GradePopup> {
  final SettingsClass settingsMenu;

  _GradePopupClass(this.settingsMenu);

  @override
  Widget build(BuildContext context) {
    var embeddedGrade = settingsMenu.grade;
    return AlertDialog(
      title: new Text("Grade"),
      content: new DropdownButton<int>(
          items: Constants.grades.map((int value) {
            return new DropdownMenuItem<int>(
              value: value,
              child: new Text(value.toString()),
            );
          }).toList(),
          onChanged: (val) {
            Storage.save("grade", val);
            setState(() {
              embeddedGrade = val;
            });
            settingsMenu.setState(() {
              settingsMenu.grade = val;
            });
          },
          value: embeddedGrade),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Save And Exit"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
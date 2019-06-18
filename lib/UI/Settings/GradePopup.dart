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

  Widget dropdown(BuildContext context) {
    var embeddedGrade = settingsMenu.grade;
    return new DropdownButton<int>(
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

          settingsMenu.setGrade(val);
        },
        value: embeddedGrade);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Grade"),
      content: dropdown(context),
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

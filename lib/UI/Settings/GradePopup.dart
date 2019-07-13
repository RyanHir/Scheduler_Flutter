import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Strings.dart';
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

  int embeddedGrade;


  Widget dropdown(BuildContext context) {
    return new DropdownButton<int>(
        items: Constants.grades.map((int value) {
          return new DropdownMenuItem<int>(
            value: value,
            child: new Text(value.toString()),
          );
        }).toList(),
        onChanged: (val) {
          if(val == 0) {
            val = 10;
          }
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
    print(embeddedGrade);
    embeddedGrade = embeddedGrade == null || embeddedGrade == 0 ? (settingsMenu == null? 10 : settingsMenu.grade) : embeddedGrade;
    return AlertDialog(
      title: new Text(Strings.grade),
      content: dropdown(context),
      actions: <Widget>[
        new FlatButton(
          child: new Text(Strings.saveAndExit),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Strings.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:scheduler/UI/Settings/GradePopup.dart';

class Settings extends StatefulWidget {
  SettingsClass createState() => SettingsClass();
}

class SettingsClass extends State<Settings> {
  int grade = 10;
  bool _loaded = false;

  _loadSettings() async {
    this.grade = await Storage.read("grade");
    setState(() {
      _loaded = true;
    });
  }

  setGrade(int val) {
    setState(() {
      grade = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loaded == false) {
      _loadSettings();
    }
    return new MaterialApp(
      theme: Theme.of(context),
      darkTheme: Theme.of(context),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Constants.settingsTitle),
          leading: new IconButton(
            icon: new Icon(Constants.backIcon),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
        ),
        body: _loaded == false
            ? new Center(child: new CircularProgressIndicator())
            : new Center(
                child: new ListView(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Constants.gradeIcon),
                        title:
                            new Text(Strings.currentGrade + grade.toString()),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return new GradePopup(this);
                              });
                        })
                  ],
                ),
              ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

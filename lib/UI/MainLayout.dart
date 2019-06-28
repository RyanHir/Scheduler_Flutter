import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Theme.dart';
import 'package:scheduler/Tools/MainLayoutProcessing.dart';
import 'package:scheduler/Tools/WidgetSelector.dart';
import 'package:scheduler/UI/MainLayout/MainAppSettings.dart';
import 'package:scheduler/UI/MainLayout/MainAppRefresh.dart';

class MainLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainLayoutClass();
  }
}

class MainLayoutClass extends State<MainLayout> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool isSignedIn = false;
  Map<String, dynamic> data;
  GoogleSignInAuthentication googleAccount;
  FirebaseUser firebaseUser;
  MainLayoutProcessing mainLayoutProcessing;

  @override
  Widget build(BuildContext context) {
    DateTime _time = new DateTime.now();
    String _day = _time.month.toString() + "/" + _time.day.toString();
    if (data == null) {
      mainLayoutProcessing = new MainLayoutProcessing(this);
      mainLayoutProcessing.refresh();
    }

    bool _schedulePresent;
    if (!isLoading) {
      if (data.keys.contains("table")) {
        _schedulePresent = true;
      } else {
        _schedulePresent = false;
      }
    } else {
      _schedulePresent = false;
    }

    return new MaterialApp(
      theme: CustomThemes.light,
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
            appBar: AppBar(
              title: new Text(Constants.title),
              actions: <Widget>[new AppBarRefresh(this), new AppBarSettings()],
              bottom: _schedulePresent && !isLoading
                  ? TabBar(
                      tabs: [
                        Tab(text: "Your Schedule"),
                        Tab(text: "Grade Schedule"),
                        Tab(text: "Your Info"),
                      ],
                    )
                  : null,
            ),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (_schedulePresent
                    ? TabBarView(
                        children: [
                          WidgetSelector(this, "personal"),
                          WidgetSelector(this, "grade"),
                          WidgetSelector(this, "info")
                        ],
                      )
                    : Center(
                        child: Text("No Schedule on $_day"),
                      ))),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void setIsLoading(bool data) {
    setState(() => this.isLoading = data);
  }

  void setIsSignedIn(bool data) {
    setState(() => this.isSignedIn = data);
  }
}

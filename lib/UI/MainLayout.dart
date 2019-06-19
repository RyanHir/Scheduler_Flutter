import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
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
    if (data == null) {
      mainLayoutProcessing = new MainLayoutProcessing(this);
      mainLayoutProcessing.refresh();
    }

    Widget appBar() {
      return new AppBar(
            title: new Text(Constants.title),
            actions: <Widget>[new AppBarRefresh(this), new AppBarSettings()],
            bottom: TabBar(
              tabs: [
                Tab(text: "Your Schedule"),
                Tab(text: "Grade Schedule"),
                Tab(text: "Your Info"),
              ],
            ),
          );
    }

    Widget appBarTabs() {
      return new TabBarView(
            children: [
              WidgetSelector(this, "personal"),
              WidgetSelector(this, "grade"),
              WidgetSelector(this, "info")
            ],
          );
    }

    return new MaterialApp(
      theme: new ThemeData(brightness: Constants.brightness),
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: appBar(),
          body: appBarTabs(),
        ),
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

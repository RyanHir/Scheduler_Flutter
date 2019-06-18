import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Tools/MainLayoutProcessing.dart';
import 'package:scheduler/Tools/WidgetSelector.dart';
import 'package:scheduler/Tools/MainAppBar.dart';

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

    return new MaterialApp(
      theme: new ThemeData(brightness: Constants.brightness),
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(Constants.title),
            actions: <Widget>[new AppBarRefresh(this), new AppBarSettings()],
            bottom: TabBar(
              tabs: [
                Tab(text: "Your Schedule"),
                Tab(text: "Grade Schedule"),
                Tab(text: "Your Info"),
              ],
            ),
          ),
          body: new TabBarView(
            children: [
              ChooseCorrectWidget(data, isLoading, isSignedIn, "personal"),
              ChooseCorrectWidget(data, isLoading, isSignedIn, "grade"),
              ChooseCorrectWidget(data, isLoading, isSignedIn, "info")
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void setFireBaseUser(FirebaseUser data) =>
      setState(() => this.firebaseUser = data);

  void setIsLoading(bool data) => setState(() => this.isLoading = data);

  void setIsSignedIn(bool data) => setState(() => this.isSignedIn = data);
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Templates/SchedulerAssets.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:scheduler/Tools/WidgetSelector.dart';
import 'package:scheduler/Tools/MainAppBar.dart';

class MainLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainLayoutClass();
  }
}

class MainLayoutClass extends State<MainLayout> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  bool isSignedIn = false;
  Map<String, dynamic> data;
  GoogleSignInAuthentication googleAccount;
  FirebaseUser firebaseUser;

  refresh() async {
    if (Constants.debug == false) {
      if (!(await _handleSignIn())) {
        print("Not Logged In");
        setState(() {
          isLoading = false;
          isSignedIn = false;
        });
        return;
      }
    }

    final token = Constants.debug ? null : this.googleAccount.idToken;
    final grade = await Storage.read("grade");

    if (grade == null) {
      setState(() {
        isLoading = false;
        isSignedIn = false;
      });
      return;
    }

    if (Constants.debug == false) {
      final jsonData = await http.get(
          Constants.endpoint + "?code=$token&grade=$grade&request=schedule");
      data = json.decode(jsonData.body);
    } else {
      final jsonData = await rootBundle.loadString("assets/example.json");
      data = json.decode(jsonData);
      print((new SchedulerAssets.fromJson(data)).gradeSchedule[1][1].text);
    }

    if (data["failed"] != null) {
      setState(() {
        this.isLoading = false;
      });
    }

    setState(() {
      this.isLoading = false;
      this.isSignedIn = true;
    });
  }

  _handleSignIn() async {
    try {
      this.firebaseUser = await _auth.currentUser();
      this.googleAccount =
          await (await _googleSignIn.signInSilently()).authentication;
    } catch (e) {
      this.firebaseUser = null;
      this.googleAccount = null;
    }
    if (this.firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      setState(() {
        isLoading = true;
      });
      refresh();
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
}

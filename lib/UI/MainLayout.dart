import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Theme.dart';
import 'package:scheduler/Tools/MainLayoutProcessing.dart';
import 'package:scheduler/UI/Settings.dart';
import 'package:scheduler/UI/Tabs/GradeTab/DrawGradeTab.dart';
import 'package:scheduler/UI/Tabs/InfoTab/DrawInfoTab.dart';
import 'package:scheduler/UI/Tabs/PersonalTab/DrawPersonalTab.dart';

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
  bool schedulePresent;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      mainLayoutProcessing = new MainLayoutProcessing(this);
      mainLayoutProcessing.refresh();
    }

    if (!isLoading) {
      if (data.keys.contains("table")) {
        schedulePresent = true;
      } else {
        schedulePresent = false;
      }
    } else {
      schedulePresent = false;
    }

    return new MaterialApp(
      theme: CustomThemes.light,
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
            appBar: CustomAppBar(
              title: Text(Constants.title),
              parent: this,
              tabController: DefaultTabController.of(context),
            ),
            body: CustomBody(
              parent: this,
              tabController: DefaultTabController.of(context),
            )),
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final TabController tabController;
  final MainLayoutClass parent;

  final Size preferredSize; // default is 56.0

  CustomAppBar({Key key, this.title, this.parent, this.tabController})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: this.title,
      actions: <Widget>[
        IconButton(
            icon: new Icon(Constants.refreshIcon),
            onPressed: () {
              parent.mainLayoutProcessing.refresh();
            }),
        IconButton(
            icon: new Icon(Constants.settingsIcon),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            }),
      ],
      bottom: parent.schedulePresent && !parent.isLoading
          ? TabBar(
              controller: tabController,
              tabs: [
                Tab(text: "Your Schedule"),
                Tab(text: "Grade Schedule"),
                Tab(text: "Your Info"),
              ],
            )
          : null,
    );
  }
}

class CustomBody extends StatelessWidget {
  final MainLayoutClass parent;
  final TabController tabController;

  CustomBody({this.parent, this.tabController});

  @override
  Widget build(BuildContext context) {
    DateTime _time = new DateTime.now();
    String day = _time.month.toString() + "/" + _time.day.toString();

    if (parent.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (parent.schedulePresent) {
      return TabBarView(
        controller: tabController,
        children: [
          DrawPersonalTable(parent.data["schedule"]),
          DrawGradeList(parent.data["table"]),
          ShowInfo(parent.data["info"])
        ],
      );
    } else {
      return Center(
        child: Text("No Schedule on $day"),
      );
    }
  }
}

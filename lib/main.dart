import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Theme.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:scheduler/UI/MainLayout.dart';

import 'Strings.dart';
import 'UI/Settings/GradePopup.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppClass();
  }
}

class _MyAppClass extends State<MyApp> {
  bool _isLoading = true;
  bool _firstTime = true;

  Future<void> checkIfFirstLoad() async {
    int _rawdata = (await Storage.read("firstload")) ?? 1;

    setState(() {
      _firstTime = _rawdata != 0 ? false : true;
      _isLoading = false;
    });
    return;
  }

  void goToHome() async {
    await Storage.save("firstload", 1);
    setState(() {
      _firstTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkIfFirstLoad();
    return _isLoading
        ? _Progress()
        : (_firstTime ? _FirstTime(this) : MainLayout());
  }
}

class _Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _FirstTime extends StatefulWidget {

  final _MyAppClass _myAppClass;

  _FirstTime(this._myAppClass);

  @override
  State<StatefulWidget> createState() {
    return _FirstTimePage(_myAppClass);
  }
}

class _FirstTimePage extends State<_FirstTime> {

  final _MyAppClass _myAppClass;

  _FirstTimePage(this._myAppClass);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAuthentication googleAccount;
  FirebaseUser firebaseUser;
  bool _signedIn = false;
  bool _gradeSelected = false;

  static _updateGoogleDisplay(String input) {
    return Strings.signedInAs + input;
  }

  _handleSignIn() async {
    if (googleAccount != null && firebaseUser != null) {
      return;
    }
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    if (user.email.endsWith("@mypisd.net")) {
      setState(() {
        this.firebaseUser = user;
        this.googleAccount = googleAuth;
        this._signedIn = true;
      });
    } else {
      _handleSignOut();
    }
  }

  _handleSignOut() async {
    setState(() {
      this.firebaseUser = null;
      this.googleAccount = null;

      this._googleSignIn.signOut();
      this._auth.signOut();
    });
  }

  setGradeSelected() {
    setState(() {
      _gradeSelected = true;
      _signedIn = _signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomThemes.light.copyWith(
          cardTheme: CustomThemes.light.cardTheme.copyWith(elevation: 12)),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Plano Academy Scheduler"),
          actions: _signedIn == true && _gradeSelected == true
              ? <Widget>[
                  IconButton(
                    onPressed: () {
                      _myAppClass.goToHome();
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ]
              : [],
        ),
        body: ListView(
          children: <Widget>[
            Card(
              color: !_signedIn ? null : Colors.green,
              child: InkWell(
                onTap: !_signedIn
                    ? () {
                        _handleSignIn();
                      }
                    : null,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _signedIn
                            ? _updateGoogleDisplay(firebaseUser.displayName)
                            : "Click to Sign In",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            _GradeSelector(this)
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _GradeSelector extends StatefulWidget {
  final _FirstTimePage parent;

  _GradeSelector(this.parent);

  @override
  State<StatefulWidget> createState() {
    return _GradeSelectorPage(parent);
  }
}

class _GradeSelectorPage extends State<_GradeSelector> {
  final _FirstTimePage parent;

  _GradeSelectorPage(this.parent);

  int grade;

  openDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return GradePopup(null);
        });
    int tempGrade = await Storage.read("grade");
    parent.setGradeSelected();
    setState(() {
      grade = tempGrade;
    });
    print(grade);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          openDialog(context);
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Text(
                grade != null
                    ? "Grade ${grade.toString()} selected"
                    : "Click to select Grade",
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}

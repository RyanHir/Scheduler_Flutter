import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:scheduler/UI/Settings/GradePopup.dart';

class Settings extends StatefulWidget {
  SettingsClass createState() => SettingsClass();
}

class SettingsClass extends State<Settings> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAuthentication googleAccount;
  FirebaseUser firebaseUser;

  String _youAre;

  bool _loaded = false;
  int grade = 10;

  static _updateGoogleDisplay(String input) {
    return "Signed In As: " + input;
  }

  _handleSignIn() async {
    if (googleAccount != null && firebaseUser != null) {
      print(_updateGoogleDisplay(firebaseUser.displayName));
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

    setState(() {
      this.firebaseUser = user;
      this.googleAccount = googleAuth;
      _youAre = _updateGoogleDisplay(firebaseUser.displayName);
    });

    print(user.displayName);
  }

  _handleSignOut() async {
    setState(() {
      _youAre = null;
      this.firebaseUser = null;
      this.googleAccount = null;

      this._googleSignIn.signOut();
      this._auth.signOut();
    });
  }


  _loadSettings() async {
    try {
      final tempUser = await _googleSignIn.signInSilently();

      this.firebaseUser = await _auth.currentUser();
      this.googleAccount = await tempUser.authentication;

      this.grade = await Storage.read("grade");
      setState(() {
        _youAre = _updateGoogleDisplay(firebaseUser.displayName);
        _loaded = true;
      });
    } catch (e) {
      setState(() {
        _youAre = null;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loaded == false) {
      _loadSettings();
    }
    return new MaterialApp(
      theme: new ThemeData(brightness: Constants.brightness),
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
                      leading: new Icon(Constants.accountIcon),
                      title: new Text(_youAre == null ? "Sign In" : _youAre),
                      onTap: () {
                        if (this.googleAccount == null) {
                          _handleSignIn();
                        } else {
                          _handleSignOut();
                        }
                      },
                    ),
                    new ListTile(
                        leading: new Icon(Icons.grade),
                        title: new Text("Grade: " + grade.toString()),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return new GradePopup(this);
                              });
                        }),
                  ],
                ),
              ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
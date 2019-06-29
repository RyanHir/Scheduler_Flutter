import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:http/http.dart' as http;
import 'package:scheduler/UI/MainLayout.dart';

class MainLayoutProcessing {
  MainLayoutClass _mainLayoutClass;

  MainLayoutProcessing(this._mainLayoutClass);

  Future<void> refresh() async {
    _mainLayoutClass.setIsLoading(true);
    if (Constants.debug == false) {
      if (!(await _handleSignIn())) {
        _mainLayoutClass.setIsLoading(false);
        _mainLayoutClass.setIsSignedIn(false);
      }
    }

    final token =
        Constants.debug ? null : _mainLayoutClass.googleAccount.idToken;
    final grade = await Storage.read("grade");

    if (grade == null) {
      _mainLayoutClass.setIsLoading(false);
      _mainLayoutClass.setIsSignedIn(false);
      return;
    }

    if (Constants.debug == false) {
      //TODO: Change Grade from 8th grade to grade var
      final jsonData = await http.get(
          Constants.endpoint + "?code=$token&grade=8&request=schedule");
      _mainLayoutClass.data = json.decode(jsonData.body);
    } else {
      final jsonData = await rootBundle.loadString("assets/example.json");
      _mainLayoutClass.data = json.decode(jsonData);
    }

    if (_mainLayoutClass.data["failed"] != null) {
      _mainLayoutClass.setIsLoading(false);
      return;
    }

    _mainLayoutClass.setIsLoading(false);
    _mainLayoutClass.setIsSignedIn(true);
  }

  Future<bool> _handleSignIn() async {
    try {
      _mainLayoutClass.firebaseUser = await _mainLayoutClass.auth.currentUser();
      _mainLayoutClass.googleAccount =
          await (await _mainLayoutClass.googleSignIn.signInSilently())
              .authentication;
    } catch (e) {
      _mainLayoutClass.firebaseUser = null;
      _mainLayoutClass.googleAccount = null;
    }
    if (_mainLayoutClass.firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }
}

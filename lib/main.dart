import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/UI/MainLayout.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppClass();
  }
}

class _MyAppClass extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MainLayout();
  }
}

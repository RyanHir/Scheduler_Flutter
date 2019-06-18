import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';

class IndividualClass extends StatelessWidget {

  final time;
  final mod;

  IndividualClass(this.time, this.mod);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(brightness: Constants.brightness),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Constants.modInfoTitle),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
        ),
        body: new ListView(children: [
          Center(child: new Text(time["text"].toString()),),
          Center(child: new Text(mod["text"].toString()))]
        )
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
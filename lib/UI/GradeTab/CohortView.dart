import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/UI/DrawTable.dart';

class CohortView extends StatelessWidget {
  final cohortData;
  final timeData;

  CohortView(this.cohortData, this.timeData);

  @override
  Widget build(BuildContext context) {
    List<dynamic> send = [timeData, cohortData];

    return new MaterialApp(
      theme: new ThemeData(brightness: Constants.brightness),
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Center(child: DrawTable(send)),
      ),
    );
  }
}

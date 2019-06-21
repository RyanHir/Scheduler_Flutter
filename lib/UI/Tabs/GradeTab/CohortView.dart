import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/UI/Tabs/GradeTab/CohortTable.dart';

class CohortView extends StatelessWidget {
  final cohortData;
  final timeData;

  CohortView(this.cohortData, this.timeData);

  @override
  Widget build(BuildContext context) {
    List<dynamic> send = [timeData, cohortData];

    return new MaterialApp(
      theme: Constants.theme,
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(send[1][0]["text"].toString()),
        ),
        body: new Center(child: DrawCohortTable(send)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

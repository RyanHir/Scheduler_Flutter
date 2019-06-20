import 'package:flutter/material.dart';

class DrawCohortTable extends StatelessWidget {
  final List<dynamic> data;

  DrawCohortTable(this.data);

  @override
  Widget build(BuildContext context) {

    List<dynamic> newData = data.toList();

    newData.forEach((obj) => obj.removeWhere(
      (item) => item["type"] == "QUERY" || item["type"] == "KEY"
    ));

    return new ListView.builder(
        itemCount: newData[0].length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            elevation: 8,
            margin: EdgeInsets.all(8.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    newData[1][i]["text"],
                    textAlign: TextAlign.center,
                  )
                ])),
          );
        });
  }
}

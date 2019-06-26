import 'package:flutter/material.dart';
import 'package:scheduler/Tools/HexColor.dart';

class DrawCohortTable extends StatelessWidget {
  final List<dynamic> data;

  DrawCohortTable(this.data);

  @override
  Widget build(BuildContext context) {
    List<dynamic> newData = [data[0].toList(), data[1].toList()];

    newData.forEach((obj) => obj.removeWhere(
        (item) => item["type"] == "QUERY" || item["type"] == "KEY"));

    return new ListView.builder(
        itemCount: newData[1].length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: Container(
              color: HexColor(data[0][i]["color"]),
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    newData[0][i]["text"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    newData[1][i]["text"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )
                ])),
          );
        });
  }
}

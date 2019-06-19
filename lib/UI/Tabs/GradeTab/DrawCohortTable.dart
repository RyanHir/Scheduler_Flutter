import 'package:flutter/material.dart';

class DrawCohortTable extends StatelessWidget {
  final data;

  DrawCohortTable(this.data);

  @override
  Widget build(BuildContext context) {
    try {
      if (data["length"] == "0") {
        return new Center(
          child: Text("No Schedule, Please Go to Grade Schedule"),
        );
      }
    } catch (e) {}

    List<dynamic> _newData = [];
    for (var x in data) {
      if (x == null) return new Center(child: Text("Please Reload Data"));
      for (var y in x) {
        _newData.insert(_newData.length, y);
      }
    }

    return new Container(
      constraints: BoxConstraints.expand(),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: data[0].length),
        itemCount: _newData.length,
        itemBuilder: (BuildContext context, int index) {
          return new GridTile(
            child: Text(_newData[index]["text"].toString()),
          );
        },
      ),
    );
  }
}
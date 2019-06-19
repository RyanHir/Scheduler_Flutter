import 'package:flutter/material.dart';

class DrawCohortTable extends StatelessWidget {
  final data;

  DrawCohortTable(this.data);

  @override
  Widget build(BuildContext context) {
    List<dynamic> _newData = [];
    for (var x in data) {
      if (x == null) return new Center(child: Text("Please Reload Data"));
      for (var y in x) {
        _newData.insert(_newData.length, y);
      }
    }

    // return new Center(
    //   child: GridView.builder(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.horizontal,
    //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: data[0].length),
    //     itemCount: _newData.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return new GridTile(
    //         child: Text(_newData[index]["text"].toString()),
    //       );
    //     },
    //   ),
    // );

    return new ListView.builder(
      itemCount: data[0].length,
      itemBuilder: (BuildContext context, int i) => Row(children: <Widget>[
        new Text(data[0][i]), new Text(data[1][i])
      ],),
    );
  }
}
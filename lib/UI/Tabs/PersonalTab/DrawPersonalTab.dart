import 'package:flutter/material.dart';
import 'package:scheduler/Strings.dart';

class DrawPersonalTable extends StatelessWidget {
  final data;

  DrawPersonalTable(this.data);

  @override
  Widget build(BuildContext context) {
    if (data["length"] == "0") {
      return new Center(
        child: Text(Strings.noScheduleError),
      );
    }

    List<dynamic> _newData = [];
    for (var x in data) {
      if (x == null) return new Center(child: Text(Strings.pleaseReload));
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

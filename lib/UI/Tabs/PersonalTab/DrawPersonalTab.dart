import 'package:flutter/material.dart';
import 'package:scheduler/Strings.dart';

class DrawPersonalTable extends StatelessWidget {
  final data;

  DrawPersonalTable(this.data);

  @override
  Widget build(BuildContext context) {
    if (data.keys.contains("failed")) {
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

    return new ListView.builder(
        itemCount: _newData[0].length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    _newData[0][i]["text"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    _newData[1][i]["text"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )
                ])),
          );
        });
  }
}

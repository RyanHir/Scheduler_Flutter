import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/Strings.dart';

class DrawPersonalTable extends StatelessWidget {
  final data;

  DrawPersonalTable(this.data);

  String _parseTime(DateTime input) {
    String hour = input.hour.toInt() > 12 ? (input.hour.toInt() - 12).toString() : input.hour.toString();
    String min = input.minute.toString();

    // if(hour.length == 1) {
    //   hour = "0$hour";
    // }
    if(min.length == 1) {
      min = "0$min";
    }

    return "$hour:$min";
  }

  @override
  Widget build(BuildContext context) {
    if (data.keys.contains("failed")) {
      return new Center(
        child: Text(Strings.noScheduleError),
      );
    }

    List<dynamic> _newData = data.keys.toList();

    _newData.removeWhere((item) => item == "length" || item == "needsSelection");

    return new ListView.builder(
        itemCount: _newData.length,
        itemBuilder: (BuildContext context, int i) {
          DateTime _beginTime = DateTime.parse(data[i.toString()]["startTime"]);
          DateTime _endTime = DateTime.parse(data[i.toString()]["endTime"]);
          return Card(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    _parseTime(_beginTime) + " - " + _parseTime(_endTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    data[i.toString()]["name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )
                ])),
          );
        });
  }
}

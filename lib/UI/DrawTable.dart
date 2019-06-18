import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';

class DrawGradeTable extends StatelessWidget {
  final List<dynamic> predata;

  DrawGradeTable(this.predata);

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = predata;
    List<dynamic> header;

    data.removeWhere((item) => item.length == 0);

    for (var x in data) {
      if (x[0]["type"].toString() == "KEY".toString()) {
        header = x;
      }
    }

    data.removeWhere((item) => item[0]["text"].toString() == "");
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        return new ListTile(
          trailing: Icon(Icons.arrow_right),
          title: new Text(data[i][0]["text"]),
          onTap: () {
            print(header);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => _CohortView(data[i], header)));
          },
        );
      },
    );
  }
}

class DrawSingleCohortTable extends StatelessWidget {
  final data;

  DrawSingleCohortTable(this.data);

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
      if (x == null)
        return new Center(
          child: Text("Please Reload Data")
        );
      for (var y in x) {
        _newData.insert(_newData.length, y);
      }
    }

    return new Container(
      constraints: BoxConstraints.expand(),
      child: 
      GridView.builder(
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

class _CohortView extends StatelessWidget {
  final cohortData;
  final timeData;

  _CohortView(this.cohortData, this.timeData);

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
        body: new Center(
            child: DrawSingleCohortTable(send)
          ),
      ),
    );
  }
}

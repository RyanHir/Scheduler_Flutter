import 'package:flutter/material.dart';
import 'package:scheduler/UI/Tabs/GradeTab/CohortView.dart';

class DrawGradeList extends StatelessWidget {
  final List<dynamic> predata;

  DrawGradeList(this.predata);

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
                builder: (context) => CohortView(data[i], header)));
          },
        );
      },
    );
  }
}
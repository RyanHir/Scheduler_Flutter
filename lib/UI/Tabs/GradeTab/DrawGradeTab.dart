import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';
import 'package:scheduler/UI/Tabs/GradeTab/CohortView.dart';

class DrawGradeList extends StatelessWidget {
  final List<dynamic> predata;

  DrawGradeList(this.predata);

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = predata.toList();
    List<dynamic> header;

    data.removeWhere((item) => item.length == 0);

    for (var x in data) {
      if (x[0]["type"].toString() == "KEY") {
        header = x.toList();
      }
    }

    data.removeWhere((item) => item[0]["type"].toString() == "KEY");
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (context, i) {
        return new ListTile(
          trailing: Icon(Constants.fowardIcon),
          title: new Text(data[i][0]["text"]),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CohortView(data[i], header)));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';

class ShowInfo extends StatelessWidget {

  final data;

  ShowInfo(this.data);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> toReturn = data;
    toReturn.removeWhere((x, y) => Constants.dataToIgnore.contains(x) || data[y] == "");

    List<String> keys = toReturn.keys.toList();

    return new ListView.separated(
      itemCount: toReturn.keys.length,
      itemBuilder: (context, i) {
        final key = keys[i].toString();
        final val = toReturn[key].toString();

        return new ListTile(
          title: Text("$key: $val")
        );
      },
      separatorBuilder: (context, index) => Divider(),

    );
  }
  
}
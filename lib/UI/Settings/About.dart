import 'package:flutter/material.dart';
import 'package:scheduler/Constants.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Add names to list
    String text = """
    Application build by 
    API build by 
    """;
    return AlertDialog(
      title: new Text("About"),
      content: new Text(text),
      actions: <Widget>[
        FlatButton(
          child: Text("Exit"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

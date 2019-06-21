import 'package:flutter/material.dart';
import 'package:scheduler/Strings.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Add names to list
    String text = """
    Application build by 
    API build by 
    """;
    return AlertDialog(
      title: new Text(Strings.about),
      content: new Text(text),
      actions: <Widget>[
        FlatButton(
          child: Text(Strings.exit),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

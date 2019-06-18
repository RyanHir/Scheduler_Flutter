import 'package:flutter/material.dart';

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
    );
  }
}

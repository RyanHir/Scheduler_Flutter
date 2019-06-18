import 'package:flutter/material.dart';

class Loading {
  Widget noTitle() {
    return new MaterialApp(
      home: Scaffold(
        body: Center(child: 
          CircularProgressIndicator()
        ),
      ),
    );
  }

  Widget wittTitle(String title) {
    return new MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: Text(title),
        ),
        body: Center(child: 
          CircularProgressIndicator()
        ),
      ),
    );
  }
}
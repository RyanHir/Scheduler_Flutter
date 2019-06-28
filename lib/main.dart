import 'package:flutter/material.dart';
import 'package:scheduler/Tools/Storage.dart';
import 'package:scheduler/UI/MainLayout.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppClass();
  }
}

class _MyAppClass extends State<MyApp> {
  bool _isLoading = false;
  bool _firstTime = true;

  Future<void> checkIfFirstLoad() async {
    int _rawdata = Storage.read("firstload") ?? 1;

    _firstTime = _rawdata == 0 ? false : true;

    return;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _Progress()
        : (!_firstTime ? _FirstTimePage() : MainLayout());
  }
}

class _Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _FirstTimePage extends StatelessWidget {
  final int _itemCount = 3;

  final List<String> _bottomText = ["aaa", "bbb", "ccc"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: TransformerPageView(
        loop: false,
        itemCount: _itemCount,
        transformer:
            PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
          return Material(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new DecoratedBox(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: [
                        Colors.red,
                        Colors.blue,
                      ],
                    ),
                  ),
                ),
                new Positioned(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new ParallaxContainer(
                        child: new Text(
                          _bottomText[info.index],
                          textAlign: TextAlign.center,
                          style: new TextStyle(fontSize: 15.0),
                        ),
                        position: info.position,
                        translationFactor: 300.0,
                      ),
                      new ParallaxContainer(
                        child: new Text(_bottomText[info.index],
                            style: new TextStyle(fontSize: 18.0)),
                        position: info.position,
                        translationFactor: 200.0,
                      ),
                    ],
                  )),
                  left: 10.0,
                  right: 10.0,
                  bottom: 10.0,
                ),
              ],
            ),
          );
        }),
      ),
    ));
  }
}

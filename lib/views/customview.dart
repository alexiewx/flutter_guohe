import 'package:flutter/material.dart';

//分隔栏
class BigDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 5.0,
      child: new Center(
        child: new Container(
          height: 5.0,
          color: Colors.black12,
        ),
      ),
    );
  }
}

//间隙
class Margin extends StatelessWidget {
  final double indent;

  const Margin({Key key, this.indent: 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(indent),
    );
  }
}

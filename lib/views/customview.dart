import 'package:flutter/material.dart';

//分隔栏
class BigDivider extends StatelessWidget{
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
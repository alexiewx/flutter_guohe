import 'package:flutter/material.dart';
import 'package:flutter_guohe/common/eventBus.dart';

class Today extends StatefulWidget {
  @override
  TodayState createState() => new TodayState();
}

class TodayState extends State<Today> {
  //打开drawer
  void openDrawer() {
    eventBus.fire(new EventOpenDrawer(true));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              //打开drawer
              openDrawer();
            },
          ),
          title: new Text("今日"), //设置标题内容
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new Center(
          child: new Text('今日'),
        ),
      ),
    );
  }
}
